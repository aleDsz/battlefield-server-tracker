# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BflistService, type: :http do
  subject { described_class.new }

  describe '#list_servers' do
    context 'with success' do
      it 'should return success monad response' do
        server = build(:bflist_server)
        body = "[#{server.to_json}]"

        expect(Faraday)
          .to receive(:get)
          .with('https://api.bflist.io/bf4/v1/servers/1')
          .and_return(Faraday::Response.new(status: 200, body: body))

        result = subject.list_servers('bf4', 1)

        expect(result).to be_success
      end

      it 'should return success monad response with pagination' do
        server1 = build(:bflist_server)
        server2 = build(:bflist_server, guid: 'de2e60c6-159a-4a5b-b30d-a1ee51998a8d')

        expect(Faraday)
          .to receive(:get)
          .with('https://api.bflist.io/bf4/v1/servers/1')
          .and_return(Faraday::Response.new(status: 200, body: "[#{server1.to_json}]"))

        expect(Faraday)
          .to receive(:get)
          .with('https://api.bflist.io/bf4/v1/servers/2')
          .and_return(Faraday::Response.new(status: 200, body: "[#{server2.to_json}]"))

        first_page = subject.list_servers('bf4', 1)
        second_page = subject.list_servers('bf4', 2)

        expect(first_page).to be_success
        expect(second_page).to be_success

        firt_page_server = first_page.value![0]
        second_page_server = second_page.value![0]

        expect(firt_page_server['guid']).not_to eq(second_page_server['guid'])
      end
    end

    context 'with failure' do
      it 'should return the message error' do
        body = '{"errors":["Endpoint not found"]}'

        expect(Faraday)
          .to receive(:get)
          .with('https://api.bflist.io/bf4/v1/servers/1')
          .and_return(Faraday::Response.new(status: 404, body: body))

        result = subject.list_servers('bf4', 1)

        expect(result).to be_failure
      end
    end
  end
end
