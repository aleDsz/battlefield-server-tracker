# frozen_string_literal: true

class CreateServers < ActiveRecord::Migration[6.1]
  def change
    create_table :servers, id: :uuid do |t|
      t.references :game, index: true, null: false
      t.datetime :created_at, null: false
    end
  end
end
