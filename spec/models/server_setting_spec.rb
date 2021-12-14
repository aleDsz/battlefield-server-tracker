# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ServerSetting, type: :model do
  context 'presence validations' do
    it { is_expected.to validate_presence_of :show_minimap }
    it { is_expected.to validate_presence_of :minimap_spotting }
    it { is_expected.to validate_presence_of :nametags }
    it { is_expected.to validate_presence_of :hud }
    it { is_expected.to validate_presence_of :third_person_spotting }
    it { is_expected.to validate_presence_of :aim_assit_slowdown }
    it { is_expected.to validate_presence_of :friendly_fire }
    it { is_expected.to validate_presence_of :kill_cam }
    it { is_expected.to validate_presence_of :only_squad_leader_spawn }
    it { is_expected.to validate_presence_of :aim_assit_auto_rotation }
    it { is_expected.to validate_presence_of :disable_team_balancer }
    it { is_expected.to validate_presence_of :regenerate_health }
    it { is_expected.to validate_presence_of :vehicle_third_person_camera }
    it { is_expected.to validate_presence_of :reload_full_mags }
    it { is_expected.to validate_presence_of :vehicle_respawn_time }
    it { is_expected.to validate_presence_of :round_time_limit }
    it { is_expected.to validate_presence_of :bullet_damage }
    it { is_expected.to validate_presence_of :ticket_count }
    it { is_expected.to validate_presence_of :respawn_time }
    it { is_expected.to validate_presence_of :player_health }
    it { is_expected.to validate_presence_of :team_ticket_count }
    it { is_expected.to validate_presence_of :teammate_kills_before_kick }
    it { is_expected.to validate_presence_of :ban_player_after_kicks }
    it { is_expected.to validate_presence_of :kick_player_after_seconds }
  end

  context 'server relationship' do
    it 'should be invalid without server detail id' do
      server_setting = ServerSetting.new(server_detail_id: nil)

      expect(server_setting).not_to be_valid
    end

    it 'should be valid' do
      server_setting = Fabricate.build(:server_setting)

      expect(server_setting).to be_valid
    end

    it 'should be invalid with inexistent server detail id' do
      server_setting = ServerSetting.new(server_detail_id: '7e629d50-87d6-40d5-b1a2-9b9480688235')

      expect(server_setting).not_to be_valid
    end
  end
end
