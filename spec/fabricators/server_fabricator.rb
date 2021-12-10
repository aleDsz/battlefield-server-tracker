# frozen_string_literal: true

Fabricator(:server) do
  game { Fabricate(:game) }
end
