require "sinatra"
require "yaml"
require "json"
require "./lib/classchange_ap"
require "./lib/easy_line_api"
require "./lib/helper"

module TmNCTClassChangeLINEBOT
  class BOT < Sinatra::Base
    post "/callback" do
    end
  end
end
