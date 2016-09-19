# coding : utf-8

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
  end
end
