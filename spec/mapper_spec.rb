require 'spec_helper'

describe 'Mapper' do
  before :each do
    VCR.use_cassette('stocks') do
      @mapper = Mapper.new
    end
  end

  describe "#parse" do
    it "parses string to a hash" do
      @mapper.stocks.should be_an_instance_of String
      @mapper.parse
      @mapper.stocks.should be_an_instance_of Hash
    end

    it "returns true if successfully parsed"
    it "returns false if error occured"
  end

  describe "#rehash" do
    it "maps data into ruby-esque column names"
  end

  describe "#find" do
    it "returns json object of given stock"
    it "returns volume, percent_change, last_trade_price, name, symbol"
  end

  describe "#all" do
    it "returns an array of json objects with stocks"

  end
end
