# frozen_string_literal: true

# The GameTools endpoint
class GameToolsService
  include Dry::Monads[:result]

  API_ENDPOINT = 'https://api.gametools.network'
  SUCCESS_STATUSES = 200..299

  def get_server(game, server_name)
    @path = "/#{game}/servers/"
    @params = { 'name' => server_name }

    request
  end

  def get_server_details(game, server_name)
    @path = "/#{game}/detailedserver/"
    @params = { 'name' => server_name }

    request
  end

  private

  attr_reader :path, :params

  def request
    response = Faraday.get(url, params)
    body = JSON.parse(response.body)

    return Success(body) if response.status in SUCCESS_STATUSES

    Failure({ status: response.status, reason: response.reason_phrase, body: body })
  end

  def url
    "#{API_ENDPOINT}#{path}"
  end
end
