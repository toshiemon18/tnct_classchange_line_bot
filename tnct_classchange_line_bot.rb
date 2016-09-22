require "sinatra"
require "yaml"
require "json"
require "./lib/classchange_ap"
require "./lib/easy_line_api"

module LineBotHelper
  def self.load_yaml
    YAML.load_file("./config/app_.yml")
  end

  def self.send_line_message(to_mid, message)
    conf = load_yaml["line"]
    client = TmNCTClassChangeLINEBOT::EasyLineAPI.new(
      channel_id: conf["channel_id"],
      channel_secret: conf["channel_secret"],
      mid: conf["mid"],
      proxy: conf["proxy"]
    ).send(to_mid, message)
  end

  def self.fetch_classchange(date)
    TmNCTClassChangeLINEBOT::TmNCTClassChangeAPI.new(date)
  end

  def self.has_classchange?(class_name, classchange)
    chasschange.has_key?(class_name)
  end
end

# regist helper module
helpers LineBotHelper

# send a message to all friends at 22:00
# update class change hash every one hour
Thread.start do
  class_change ||= LineBotHelper.fetch_classchange(Time.now)
  prev_hour = Time.now.hour
  loop do
    date = Time.now
    current_hour = date.hour
    if date.wday == 0 or date.wday == 6
      sleep 200
      next
    end

    diff_hour = current_hour - prev_hour
    if diff_hour != 0
      # update class change
      class_change ||= LineBotHelper.fetch_classchange(date)
      prev_hour = current_hour
    end

    if current_time == 22
      # send a message to all friends
    end
  end
end

# destination of callback url of sent message
post "/callback" do

end
