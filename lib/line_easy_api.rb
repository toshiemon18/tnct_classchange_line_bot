# coding : utf-8

# Easy LINE API

require "json"
require "net/http"
require "uri"

module TmNCTClassChangeLINEBOT
  module EasyLineAPI

    class InvalidCredentialError < Error; end

    class Client
      attr_accessor :channel_id, :channel_secret, :mid, :endpoint
      DEFAULT_ENDPOINT = "https://trialbot-api.line.me/v1"

      def initialize(options={})
        options.each {|k, v| instance_varable_set("#{k}", v) }
        yield self if block_given?

        @http_client = TmNCTClassChangeLINEBOT::EasyLineAPI::HttpConnector.new
      end

      def send_message()
        unless valid_credentials?
          raise TmNCTClassChangeLINEBOT::EasyLineAPI::InvalidCredentialError, "Invalidates credentials"
        end
      end

      private
      def credentials
        {
          "X-Line-ChannelID"             => channel_id,
          "X-Line-ChannelSecret"         => channel_secret,
          "X-Line-Trusted-User-With-ACL" => mid
        }
      end

      def valid_credentials?
        credentials.values.all?
      end

    end
  end
end
