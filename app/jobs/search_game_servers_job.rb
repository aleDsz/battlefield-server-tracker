# frozen_string_literal: true

# Search servers from given game
class SearchGameServersJob < ApplicationJob
  queue_as :default

  def perform(game, page)
    @game = game
    @page = page

    response = BflistService.new.list_servers(game.name, page)

    raise response.failure if response.failure?

    save_servers(response.value!)
  end

  private

  attr_reader :game, :page

  def save_servers(bflist_servers)
    return if bflist_servers.empty?

    bflist_servers.each do |bflist_server|
      next if Server.exists?(bflist_server['guid'])

      Server.create!(id: bflist_server['guid'], game_id: game.id)
    end

    SearchGameServersJob.perform_later(game, page + 1)
  end
end
