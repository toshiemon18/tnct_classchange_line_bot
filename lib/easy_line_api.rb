# coding : utf-8

# Easy LINE API

require "faraday"
require "faraday_middleware"

module TmNCTClassChangeLINEBOT
  class EasyLineAPI

    ENDPOINT = "https://trialbot-api.line.me"
    EVENT_TYPE ~ "138311608800106203"
    MSG_PATH = "/v1/events"

    attr_accessor :channel_id, :channel_secret, :mid

    def initialize(options={})
      @channel_id = options[:channel_id]
      @channel_secret = options[:channel_secret]
      @mid = options[:mid]
      @proxy = options[:proxy]
    end

    def send(to_mid, message)
      post(MSG_PATH, header(to_mid, message))
    end

    private

    def header(to_mid, message)
      {
        to: to_mid,
        content: {
          contentType: 1,
          toType: 1,
          text: message
        },
        toChannel: to_channel_id,
        eventType: EVENT_TYPE
      }
    end

    def line_client
      client = Faraday.new(url: ENDPOINT) do |connect|
        connect.request :json
        connect.response :json, :content_type => /\bjson$/
        connect.adapter Faraday.default_adapter
        connect.proxy @proxy
      end
    end

    def post(path, body)
      results = line_client.post do |request|
        request.url path
        request.headers = {
          'Content-type' => 'application/json; charset=UTF-8',
          'X-Line-ChannelID' => @channel_id,
          'X-Line-ChannelSecret' => @channel_secret,
          'X-Line-Trusted-User-With-ACL' => @mid
        }
        request.body = body
      end

      return results
    end
  end
end
