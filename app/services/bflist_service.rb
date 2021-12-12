# frozen_string_literal: true

# The Bflist endpoint
class BflistService
  include Dry::Monads[:result]

  API_ENDPOINT = 'https://api.bflist.io'
  SUCCESS_STATUSES = 200..299

  def list_servers(game, page)
    @game = game
    @path = "/servers/#{page}"

    request
  end

  private

  attr_reader :path, :game

  def request
    response = Faraday.get(url)
    body = JSON.parse(response.body)

    return Success(body) if response.status in SUCCESS_STATUSES

    Failure({ status: response.status, reason: response.reason_phrase, body: body })
  end

  def endpoint
    "#{API_ENDPOINT}/#{game}/v1"
  end

  def url
    "#{endpoint}#{path}"
  end
end
