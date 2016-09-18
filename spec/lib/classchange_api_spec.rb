require "json"
require "spec_helper"
require "classchange_api"

describe TmNCTClassChangeLINEBOT::TmNCTClassChangeAPI do
  describe "#run" do
    before do
      @client = TmNCTClassChangeLINEBOT::TmNCTClassChangeAPI.new(
        url: "http://jyugyou.tomakomai-ct.ac.jp/jyugyou.php?date=2016.7.25",
        xpath: "//table[@width=\"70%\"]/tr[@height=\"35\"]"
      )
      @sample_hash = {
        a: 10,
        b: 30
      }
    end

    context "class of return value is String" do
      it { expect(@client.run.class).to eq(@sample_hash.to_json.class) }
    end

    context "number of elements will be 8" do
      it do
        json_hash = JSON.parse(@client.run)
        expect(json_hash.size).to eq(8)
      end
    end
  end
end
