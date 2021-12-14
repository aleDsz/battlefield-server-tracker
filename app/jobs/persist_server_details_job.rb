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
    PersistServerDetails.persist_for_bf4(
      body: body,
      game: game,
      server: server,
      server_details: server_details
    )

    Success()
  end
end
