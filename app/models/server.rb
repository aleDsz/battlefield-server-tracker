# frozen_string_literal: true

# The server model that stores all available servers
# from a game to track 'em
class Server < ApplicationRecord
  belongs_to :game, required: true
end
