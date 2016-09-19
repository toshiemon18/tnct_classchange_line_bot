# coding : utf-8

# Easy LINE API

require "json"
require "net/http"
require "uri"

module TmNCTClassChangeLINEBOT
  module EasyLineAPI
    class HttpConnector
      def get(url, header={})
        uri = URI(url)
        http_client.get(uri.request_uri, header)
      end

      def post(url, payload, header={})
        uri = URI(url)
        http_client.post(uri.request_uri, payload, header)
      end

      def http_client(uri)
        client = Net::HTTP.new(uri.host, uri.port)
        client.use_ssl = true if uri.scheme == "https"
        client
      end
    end

    class Client
      attr_accessor :channel_id, :channel_secret, :mid, :endpoint

      def initialize(options={})
        options.each {|k, v| instance_varable_set("#{k}", v) }
        yield self if block_given?

        @http_client = TmNCTClassChangeLINEBOT::EasyLineAPI::HttpConnector.new
      end
    end
  end
end
