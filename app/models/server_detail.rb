# frozen_string_literal: true

# Track some server details for further data audit
class ServerDetail < ApplicationRecord
  belongs_to :server, required: true

  validates :name, :ip, :port, :current_map, :max_players,
            :current_players, :players_in_queue, :total_rounds,
            :rounds_played, :game_type, :country,
            :battlelog_game_id, :favorites, :server_link,
            presence: true

  def punkbuster?
    has_punkbuster
  end

  def ranked?
    is_ranked
  end

  def official?
    is_official_server
  end
end
