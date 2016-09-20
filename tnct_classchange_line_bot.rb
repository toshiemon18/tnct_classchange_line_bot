require "sinatra"
require "yaml"
require "json"
require "./lib/classchange_ap"
require "./lib/easy_line_api"

module TmNCTClassChangeLINEBOT
  class Helper
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

    def fetch_classchange
      TmNCTClassChangeLINEBOT::TmNCTClassChangeAPI.new(
        url: @yaml["url"],
        xpath: @yaml["xpath"]
      ).run
    end
  end

  class BOT < Sinatra::Base
    post "/callback" do
      req = JSON.parse(request.body.read)


    end
  end
end
