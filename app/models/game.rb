# frozen_string_literal: true

# The game model that stores all available games to
# search servers and track 'em
class Game < ApplicationRecord
  validates :name, :description, :status, presence: true
  validates :status, inclusion: %w(active inactive)
end
