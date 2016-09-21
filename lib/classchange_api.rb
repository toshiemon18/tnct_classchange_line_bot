# coding : utf-8

# Scrape TmNCT class change page
# http://jyugyou.tomakomai-ct.ac.jp/jyugyou.php

require "open-uri"
require "uri"
require "nokogiri"
require "nkf"

module TmNCTClassChangeLINEBOT
  class TmNCTClassChangeAPI
    ENDPOINT = "http://jyugyou.tomakomai-ct.ac.jp/jyugyou.php"
    XPATH = "//table[@width=\"70%\"]/tr[@height=\"35\"]"

    attr_accessor :date

    def initialize(date)
      @url = generate_query(date)
    end

    def run
      fetch
    end

    def date=(date)
      self.date
      @url = generate_query(date)
    end

    private

    def generate_query(time)
      ENDPOINT + "?date=#{time.year}.#{time.month}.#{time.day}"
    end

    def fetch
      charset = nil
      html = open(@url) do |stream|
        charset = stream.charset
        stream.read
      end

      doc = Nokogiri::HTML.parse(html, nil, charset)
      classchange_hash = doc_to_hash(doc)

      return classchange_hash
    end

    def doc_to_hash(doc)
      cc_hash = {}
      prev_key = ""
      doc.xpath(XPATH).each do |elem|
        class_name = elem.css("th").text
        class_name = NKF.nkf('-m0Z1 -W -w', class_name)
        prev_key = class_name unless class_name.empty?
        cc = pick_up_classchange(elem)

        if class_name.empty?
          cc_hash[prev_key] << cc
        else
          cc_hash[class_name] = [cc]
        end
      end

      return cc_hash
    end

    def pick_up_classchange(node)
      context = node.css("td").text
      context.gsub!(URI.decode("%E3%83%BB"), ", ") if context.match(URI.decode("%E3%83%BB"))
      context = NKF.nkf('-m0Z1 -W -w', context)
    end
  end
end
