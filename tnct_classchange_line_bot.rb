require "sinatra"
require "yaml"
require "json"
require "./lib/classchange_ap"
require "./lib/easy_line_api"

module TmNCTClassChangeLINEBOT
  class Helper
    CLASS_NAME_LIST = {
      "1年1組" => ["1-1"], "1年2組" => ["1-2"], "1年3組" => ["1-3"],
      "1年4組" => ["1-4"], "1年5組" => ["1-5"]
    }

    def initialize
      @yaml = YAML.load_file("./config/app.yml")
    end

    def line_client
      client = TmNCTClassChangeLINEBOT::EasyLineAPI.new(
        channel_id: @yaml["line"]["channel_id"],
        channel_secret: @yaml["line"]["channel_secret"],
        mid: @yaml["line"]["mid"],
        proxy: @yaml["line"]["proxy"]
      )
      client.endpoint = @yaml["line"]["endpoint"]
      client.event_type = @yaml["line"]["event_type"]
      client.path = @yaml["line"]["path"]
    end

    def classchange_client
      TmNCTClassChangeLINEBOT::TmNCTClassChangeAPI.new(
        url: @yaml["url"],
        xpath: @yaml["xpath"]
      )
    end

    def translate_to_key(class_name)
      CLASS_NAME_LIST.each do |key, val|
        if key == class_name
          yield key
        else
          val.each do |cn|
            yield key if cn == class_name
          end
        end
      end

      return false
    end

    def has_classchange?(class_name, classchange)
      chasschange.has_key?(class_name)
    end

    def fetch_current_time
      Time.now
    end
  end

  class BOT < Sinatra::Base
    attr_accessor :classchange

    def load_helper
      @helper = TmNCTClassChangeLINEBOT::Helper.new
    end

    def fetch_classchange
      self.classchange = @helper.classchange_client.run
    end

    post "/callback" do
      load_helper

      current_time = @helper.fetch_current_time

      params = JSON.parse(request.body.read)
      params[:result].each do |msg|
        next if msg["content"]["contentType"] != 1
        message = msg["content"]["text"]
        from_user_id = msg["content"]["from"]

        key = translate_to_key(message)
        if !key
          @helper.line_client.send(from_user_id, "そのクラスは存在しませんよ！")
        elsif !@helper.has_classchange?(key, classchange)
          @helper.line_client.send(from_user_id, "授業変更はありません！")
        else
          @helper.line_client.send(from_user_id,
            ""
          )
        end
      end
    end
  end
end
