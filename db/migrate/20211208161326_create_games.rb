# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
