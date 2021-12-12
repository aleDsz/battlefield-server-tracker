# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GameToolsService, type: :http do
  subject { described_class.new }

  describe '#get_server' do
    let(:server_name) { 'Battlefield da Depressao - LOCKER 24/7 50Hz - i3D.net' }
    let(:endpoint) { 'https://api.gametools.network/bf4/servers/' }
    let(:params) { { 'name' => server_name } }

    context 'with success' do
      it 'should return success monad response' do
        servers = build(:game_tools_servers)

        expect(Faraday)
          .to receive(:get)
          .with(endpoint, params)
          .and_return(Faraday::Response.new(status: 200, body: servers.to_json))

        result = subject.get_server('bf4', server_name)

        expect(result).to be_success
      end
    end

    context 'with failure' do
      it 'should return the message error' do
        error = {
          'detail' => [
            {
              'loc' => %w(query name),
              'msg' => 'field required',
              'type' => 'value_error.missing'
            }
          ]
        }

        expect(Faraday)
          .to receive(:get)
          .with(endpoint, params)
          .and_return(Faraday::Response.new(status: 422, body: error.to_json))

        result = subject.get_server('bf4', server_name)

        expect(result).to be_failure
      end
    end
  end

  describe '#get_server_details' do
    let(:server_name) { 'Battlefield da Depressao - LOCKER 24/7 50Hz - i3D.net' }
    let(:endpoint) { 'https://api.gametools.network/bf4/detailedserver/' }
    let(:params) { { 'name' => server_name } }

    context 'with success' do
      it 'should return success monad response' do
        server_details = build(:game_tools_server_details)

        expect(Faraday)
          .to receive(:get)
          .with(endpoint, params)
          .and_return(Faraday::Response.new(status: 200, body: server_details.to_json))

        result = subject.get_server_details('bf4', server_name)

        expect(result).to be_success
      end
    end

    context 'with failure' do
      it 'should return the message error' do
        error = { 'errors' => ['error getting server info'] }

        expect(Faraday)
          .to receive(:get)
          .with(endpoint, params)
          .and_return(Faraday::Response.new(status: 422, body: error.to_json))

        result = subject.get_server_details('bf4', server_name)

        expect(result).to be_failure
      end
    end
  end
end
