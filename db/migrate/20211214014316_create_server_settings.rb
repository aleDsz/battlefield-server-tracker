# frozen_string_literal: true

class CreateServerSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :server_settings do |t|
      t.integer :server_detail_id, null: false
      t.string :show_minimap, null: false, default: 'off'
      t.string :minimap_spotting, null: false, default: 'off'
      t.string :nametags, null: false, default: 'off'
      t.string :hud, null: false, default: 'off'
      t.string :third_person_spotting, null: false, default: 'off'
      t.string :aim_assit_slowdown, null: false, default: 'off'
      t.string :friendly_fire, null: false, default: 'off'
      t.string :kill_cam, null: false, default: 'off'
      t.string :only_squad_leader_spawn, null: false, default: 'off'
      t.string :aim_assit_auto_rotation, null: false, default: 'off'
      t.string :disable_team_balancer, null: false, default: 'off'
      t.string :regenerate_health, null: false, default: 'off'
      t.string :vehicle_third_person_camera, null: false, default: 'off'
      t.string :reload_full_mags, null: false, default: 'off'
      t.string :vehicle_respawn_time, null: false, default: '1.0'
      t.string :round_time_limit, null: false, default: '1.0'
      t.string :bullet_damage, null: false, default: '1.0'
      t.string :ticket_count, null: false, default: '1.0'
      t.string :respawn_time, null: false, default: '1.0'
      t.string :player_health, null: false, default: '1.0'
      t.string :team_ticket_count, null: false, default: '1.0'
      t.string :teammate_kills_before_kick, null: false, default: '1.0'
      t.string :ban_player_after_kicks, null: false, default: '1.0'
      t.string :kick_player_after_seconds, null: false, default: '1.0'
      t.datetime :created_at, null: false
    end

    add_foreign_key :server_settings, :server_details
  end
end
