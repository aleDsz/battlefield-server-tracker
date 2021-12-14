# frozen_string_literal: true

class CreateServerDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :server_details do |t|
      t.uuid :server_id, null: false
      t.string :name, null: false
      t.string :ip, null: false
      t.integer :port, null: false
      t.string :current_map, null: false
      t.integer :max_players, null: false
      t.integer :current_players, null: false
      t.integer :players_in_queue, null: false
      t.integer :total_rounds, null: false
      t.integer :rounds_played, null: false
      t.string :game_type, null: false
      t.boolean :is_ranked, null: false, default: true
      t.boolean :has_punkbuster, null: false, default: true
      t.boolean :is_official_server, null: false, default: false
      t.string :country, null: false
      t.string :battlelog_game_id, null: false
      t.string :favorites, null: false
      t.string :server_link, null: false
      t.datetime :created_at, null: false
    end
  end
end
