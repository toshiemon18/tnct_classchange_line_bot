require "sinatra"
require "yaml"
require "json"
require "./lib/classchange_ap"
require "./lib/easy_line_api"
require "./lib/helper"

module TmNCTClassChangeLINEBOT
  class BOT < Sinatra::Base
    attr_accessor :classchange

    def run!

      super
    end

    post "/callback" do
    end
  end
end
