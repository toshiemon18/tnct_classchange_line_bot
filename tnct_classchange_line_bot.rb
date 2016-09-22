require 'active_support/all'
require "sinatra"
require "yaml"
require "json"
require "./lib/classchange_ap"
require "./lib/easy_line_api"

class LineBotHelper
  attr_accessor :date

  def initialize
    YAML.load_file("./config/app.yml")
  end

  def line_client
    conf = load_yaml["line"]
    client = TmNCTClassChangeLINEBOT::EasyLineAPI.new(
      channel_id: conf["channel_id"],
      channel_secret: conf["channel_secret"],
      mid: conf["mid"],
      proxy: conf["proxy"]
    )
  end

  def classchange_client
    TmNCTClassChangeLINEBOT::TmNCTClassChangeAPI.new(self.date)
  end

  def has_classchange?(class_name, classchange)
    chasschange.has_key?(class_name)
  end
end

helper = LineBotHelper.new

# send a message to all friends at 22:00
# update class change hash every one hour
Thread.start do
  prev_time = Time.now.hour
  loop do
    current_time = Time.now.hour
    diff_time = current_time - prev_time
    if diff_time != 0
      prev_time = current_time
    end

    if current_time == 22
      # send a message to all friends
    end
  end
end

# destination of callback url of sent message
post "/linebot/callback" do

end
