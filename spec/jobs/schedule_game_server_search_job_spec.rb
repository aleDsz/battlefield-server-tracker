# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ScheduleGameServerSearchJob, type: :job do
  let(:enqueue_delay) { 30.minutes }

  describe '#perform_later' do
    it 'enqueues itself' do
      described_class.perform_later(scheduled_to: DateTime.now, first_run: true)
      expect(described_class).to have_been_enqueued
    end

    context 'performs the job' do
      before do
        ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      end

      context 'and existent games in database' do
        it 'enqueues the search game servers job' do
          freeze_time
          scheduled_to = DateTime.now
          next_scheduled_to = scheduled_to + enqueue_delay

          expect(described_class)
            .to receive(:perform_later)
            .with(scheduled_to: scheduled_to, first_run: true)
            .and_call_original

          expect(described_class)
            .to receive(:perform_later)
            .with(scheduled_to: next_scheduled_to)
            .and_return(true)

          game = Fabricate(:game, name: 'bf4')

          expect(SearchGameServersJob)
            .to receive(:perform_later)
            .with(game, 1)
            .and_return(true)

          described_class.perform_later(scheduled_to: scheduled_to, first_run: true)
        end
      end
    end
  end

  describe '#perform_now' do
    let(:scheduled_to) { DateTime.now }

    before do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    end

    context 'performs the job' do
      it 'enqueues the next job' do
        freeze_time
        next_scheduled_to = scheduled_to + enqueue_delay

        expect(described_class)
          .to receive(:perform_later)
          .with(scheduled_to: next_scheduled_to)
          .and_return(true)

        described_class.perform_now(scheduled_to: scheduled_to, first_run: true)
      end
    end
  end
end
