require "sinatra"
require "yaml"
require "json"
require "./lib/classchange_ap"
require "./lib/easy_line_api"
require "./lib/helper"

module TmNCTClassChangeLINEBOT
  class BOT < Sinatra::Base
    attr_accessor :classchange

<<<<<<< HEAD
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
=======
    def initialize
      @helper = TmNCTClassChangeLINEBOT::Helper.new
    end

    post "/callback" do
>>>>>>> a50c891b30d2d08bc51b8a3ae1666d02bef1d86c
    end
  end
end
