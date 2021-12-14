# frozen_string_literal: true

# Stores the Server settings
class ServerSetting < ApplicationRecord
  BOOLEAN_FIELDS = %i(minimap_spotting nametags hud
                      third_person_spotting aim_assit_slowdown
                      friendly_fire kill_cam only_squad_leader_spawn
                      aim_assit_auto_rotation disable_team_balancer regenerate_health
                      vehicle_third_person_camera reload_full_mags).freeze

  belongs_to :server_detail, required: true

  validates :show_minimap, :minimap_spotting, :nametags, :hud, :third_person_spotting,
            :aim_assit_slowdown, :friendly_fire, :kill_cam, :only_squad_leader_spawn,
            :aim_assit_auto_rotation, :disable_team_balancer, :regenerate_health,
            :vehicle_third_person_camera, :reload_full_mags, :vehicle_respawn_time,
            :round_time_limit, :bullet_damage, :ticket_count, :respawn_time,
            :player_health, :team_ticket_count, :teammate_kills_before_kick,
            :ban_player_after_kicks, :kick_player_after_seconds,
            presence: true

  # Creates dynamically boolean methods for
  # stringfied boolean fields
  BOOLEAN_FIELDS.each do |attribute|
    define_method(:"#{attribute}?") do
      public_send(attribute) == 'on'
    end
  end
end
