# frozen_string_literal: true

Fabricator(:server_setting) do
  server_detail { Fabricate(:server_detail) }
  show_minimap { 'off' }
  minimap_spotting { 'off' }
  nametags { 'off' }
  hud { 'off' }
  third_person_spotting { 'off' }
  aim_assit_slowdown { 'off' }
  friendly_fire { 'off' }
  kill_cam { 'off' }
  only_squad_leader_spawn { 'off' }
  aim_assit_auto_rotation { 'off' }
  disable_team_balancer { 'off' }
  regenerate_health { 'off' }
  vehicle_third_person_camera { 'off' }
  reload_full_mags { 'off' }
  vehicle_respawn_time { '1.0' }
  round_time_limit { '1.0' }
  bullet_damage { '1.0' }
  ticket_count { '1.0' }
  respawn_time { '1.0' }
  player_health { '1.0' }
  team_ticket_count { '1.0' }
  teammate_kills_before_kick { '1.0' }
  ban_player_after_kicks { '1.0' }
  kick_player_after_seconds { '1.0' }
end
