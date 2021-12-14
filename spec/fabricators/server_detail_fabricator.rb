# frozen_string_literal: true

Fabricator(:server_detail) do
  server { Fabricate(:server) }
  name { Faker::Name.name }
  ip { Faker::Internet.ip_v4_address }
  port { 12_345 }
  current_map { 'Operation Locker' }
  max_players { 64 }
  current_players { 64 }
  players_in_queue { 0 }
  total_rounds { 123 }
  rounds_played { 1 }
  game_type { 'Conquest small' }
  is_ranked { true }
  has_punkbuster { true }
  is_official_server { false }
  country { Faker::Address.state_abbr }
  battlelog_game_id { '231321345651656581' }
  favorites { '1234' }
  server_link { 'https://localhost/game/123' }
end
