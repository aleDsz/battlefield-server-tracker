# frozen_string_literal: true

# Persist the given server with given details
# from it to track 'em
class PersistServerDetailsJob < ApplicationJob
  include Dry::Monads[:result]

  queue_as :default

  def perform(bflist_server, game)
    @game = game
    @body = bflist_server
    @api = GameToolsService.new

    do_get_server
      .bind { do_get_server_details }
      .bind { persist_details! }
  end

  private

  attr_reader :api, :body, :game, :server, :server_details

  def do_get_server # rubocop:disable Metrics/AbcSize
    result = api.get_server(game.name, body['name'])

    return result if result.failure?

    servers = result.value!['servers']
    servers = servers.filter { |server| server['battlelogId'] == body['guid'] }

    return Failure(:server_not_found) if servers.empty?
    return Failure(:not_unique_server) if servers.length > 1

    @server = servers.first

    Success(servers)
  end

  def do_get_server_details
    result = api.get_server_details(game.name, body['name'])

    return result if result.failure?

    @server_details = result.value!

    result
  end

  def persist_details!
    ServerDetail.create!(attrs)

    Success()
  end

  def attrs # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    {
      server_id: body['guid'],
      name: body['name'],
      ip: body['ip'],
      port: body['port'],
      current_map: body['mapLabel'],
      max_players: body['maxPlayers'],
      current_players: body['numPlayers'],
      players_in_queue: server['inQue'],
      total_rounds: body['roundsTotal'],
      rounds_played: body['roundsPlayed'],
      game_type: server['mode'],
      is_ranked: body['ranked'],
      has_punkbuster: body['punkbuster'],
      is_official_server: server['official'],
      country: body['country'],
      battlelog_game_id: server['gameId'],
      favorites: server_details['favorites'],
      server_link: server['serverLink']
    }
  end
end
