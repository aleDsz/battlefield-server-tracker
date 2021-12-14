# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PersistServerDetailsJob, type: :job do
  describe '#perform_later' do
    context 'performs the job' do
      let(:game) { Fabricate(:game, name: 'bf4') }
      let(:server_name) { 'Battlefield da Depressao - LOCKER 24/7 50Hz - i3D.net' }
      let(:params) { { 'name' => server_name } }
      let(:bflist_server) { build(:bflist_server, name: server_name) }
      let(:server) { build(:game_tools_server, battlelogId: bflist_server['guid']) }
      let(:server_details) { build(:game_tools_server_details) }
      let(:servers) { build(:game_tools_servers, servers: [server]) }

      before do
        ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
        Fabricate(:server, id: bflist_server['guid'], game: game)
      end

      context 'with success' do
        before do
          expect(Faraday)
            .to receive(:get)
            .with("https://api.gametools.network/#{game.name}/servers/", params)
            .and_return(Faraday::Response.new(status: 200, body: servers.to_json))

          expect(Faraday)
            .to receive(:get)
            .with("https://api.gametools.network/#{game.name}/detailedserver/", params)
            .and_return(Faraday::Response.new(status: 200, body: server_details.to_json))
        end

        it 'persist the server details into database' do
          expect { described_class.perform_later(bflist_server, game) }
            .to change { ServerDetail.count }
            .from(0).to(1)
        end
      end

      context 'with failure' do
        let(:error) do
          {
            'detail' => [
              {
                'loc' => %w(query name),
                'msg' => 'field required',
                'type' => 'value_error.missing'
              }
            ]
          }
        end

        it 'fails to get the server from GameTools API' do
          expect(Faraday)
            .to receive(:get)
            .with("https://api.gametools.network/#{game.name}/servers/", params)
            .and_return(Faraday::Response.new(status: 422, body: error.to_json))

          expect { described_class.perform_later(bflist_server, game) }
            .not_to change(ServerDetail, :count)
        end

        it 'fails to get the server details from GameTools API' do
          expect(Faraday)
            .to receive(:get)
            .with("https://api.gametools.network/#{game.name}/servers/", params)
            .and_return(Faraday::Response.new(status: 200, body: servers.to_json))

          expect(Faraday)
            .to receive(:get)
            .with("https://api.gametools.network/#{game.name}/detailedserver/", params)
            .and_return(Faraday::Response.new(status: 422, body: error.to_json))

          expect { described_class.perform_later(bflist_server, game) }
            .not_to change(ServerDetail, :count)
        end
      end
    end
  end
end
