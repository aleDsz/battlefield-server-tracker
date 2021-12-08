# frozen_string_literal: true

Fabricator(:game) do
  name { Faker::Name.name }
  description { Faker::Game.name }
  status 'active'
end
