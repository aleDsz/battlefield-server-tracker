# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Server, type: :model do
  context 'game relationship' do
    it 'should be invalid without game id' do
      server = Server.new(game_id: nil)

      expect(server).not_to be_valid
    end

    it 'should be valid' do
      server = Server.new(game_id: Fabricate(:game).id)

      expect(server).to be_valid
    end

    it 'should be invalid with inexistent game id' do
      server = Server.new(game_id: 7_423_647)

      expect(server).not_to be_valid
    end
  end
end
