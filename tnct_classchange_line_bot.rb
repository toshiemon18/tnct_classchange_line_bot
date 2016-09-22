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

# 22時に翌日の授業変更の通知を行うためのスレッド
# 1時間毎に授業変更のデータを更新する
Thread.start do
  prev_time = Time.now.hour
  loop do
    current_time = Time.now.hour
    diff_time = current_time - prev_time
    if diff_time != 0
      prev_time = current_time
    end

    if current_time == 22

    end
  end
end

# メッセージを転送してもらうコールバック先
post "/linebot/callback" do

end
