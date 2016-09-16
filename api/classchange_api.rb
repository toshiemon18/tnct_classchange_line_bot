# coding : utf-8

# TNCT ClassChange API
# http://jyugyou.tomakomai-ct.ac.jp/jyugyou.php

require "open-uri"
require "nokogiri"

module TNCTClassChangeLINEBOT
  class ChassChangeAPI
    def initialize(url, xpath)
      @url = url
    end

    def fetch_classchange
      charset = nil
      html = open(url) do |stream|
        charset = stream.charset
        stream.read
      end

      page = Nokogiri::HTML.parse(html, nil, charset)
    end
  end
end
