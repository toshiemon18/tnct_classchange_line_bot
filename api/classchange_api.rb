# coding : utf-8

# Scrape TNCT class change page
# http://jyugyou.tomakomai-ct.ac.jp/jyugyou.php

require "open-uri"
require "nokogiri"

module TNCTClassChangeLINEBOT
  class ScrapeClassChange
    def initialize(api_config)
      config = api_config
      # @url = config["url"]
      # @xpath = config["xpath"]
      @url = "http://jyugyou.tomakomai-ct.ac.jp/jyugyou.php?date=2016.7.27"
      @xpath = "//table[@width=\"70%\"]/tr[@height=\"35\"]"
    end

    def fetch_classchange
      charset = nil
      html = open(@url) do |stream|
        charset = stream.charset
        stream.read
      end

      doc = Nokogiri::HTML.parse(html, nil, charset)
      # puts doc.xpath(@xpath).each {|e| puts e}
      classchange_hash = {}
      # th_tag = doc.xpath(@xpath)[0]
      # puts th_tag.inner_html
      doc.xpath(@xpath).each do |elem|
        puts elem.css()
      end
    end
  end
end

mod = TNCTClassChangeLINEBOT::ScrapeClassChange.new(nil)
mod.fetch_classchange
