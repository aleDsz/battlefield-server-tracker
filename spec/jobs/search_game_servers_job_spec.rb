# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SearchGameServersJob, type: :job do
  describe '#perform_later' do
    let(:game) { Fabricate(:game, name: 'bf4') }

    before do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    end

    context 'performs the job' do
      let(:server) { build(:bflist_server) }

      before do
        expect(Faraday)
          .to receive(:get)
          .with('https://api.bflist.io/bf4/v1/servers/1')
          .and_return(Faraday::Response.new(status: 200, body: "[#{server.to_json}]"))

        expect(described_class)
          .to receive(:perform_later)
          .with(game, 1)
          .and_call_original

        expect(described_class)
          .to receive(:perform_later)
          .with(game, 2)
      end

      it 'creates server and schedule the job for the next page' do
        expect { described_class.perform_later(game, 1) }
          .to change { Server.count }
          .from(0).to(1)

        expect(Server.first.id).to eq(server['guid'])
      end
    end
  end
end
