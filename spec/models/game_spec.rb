# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Game, type: :model do
  context 'presence validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :status }
  end

  context 'inclusion validations' do
    it { is_expected.to validate_inclusion_of(:status).in_array %w(active inactive) }
    it { is_expected.not_to validate_inclusion_of(:status).in_array %w(foo bar baz) }
  end
end
