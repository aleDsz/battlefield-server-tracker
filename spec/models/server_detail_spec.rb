# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ServerDetail, type: :model do
  context 'presence validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :ip }
    it { is_expected.to validate_presence_of :port }
    it { is_expected.to validate_presence_of :current_map }
    it { is_expected.to validate_presence_of :max_players }
    it { is_expected.to validate_presence_of :current_players }
    it { is_expected.to validate_presence_of :players_in_queue }
    it { is_expected.to validate_presence_of :total_rounds }
    it { is_expected.to validate_presence_of :rounds_played }
    it { is_expected.to validate_presence_of :game_type }
    it { is_expected.to validate_presence_of :country }
    it { is_expected.to validate_presence_of :battlelog_game_id }
    it { is_expected.to validate_presence_of :favorites }
  end

  context 'server relationship' do
    it 'should be invalid without server id' do
      server_detail = ServerDetail.new(server_id: nil)

      expect(server_detail).not_to be_valid
    end

    it 'should be valid' do
      server_detail = Fabricate.build(:server_detail)

      expect(server_detail).to be_valid
    end

    it 'should be invalid with inexistent server id' do
      server_detail = ServerDetail.new(server_id: '7e629d50-87d6-40d5-b1a2-9b9480688235')

      expect(server_detail).not_to be_valid
    end
  end
end
