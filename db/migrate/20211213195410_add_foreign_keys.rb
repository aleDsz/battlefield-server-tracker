# frozen_string_literal: true

class AddForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :servers, :games
    add_foreign_key :server_details, :servers
  end
end
