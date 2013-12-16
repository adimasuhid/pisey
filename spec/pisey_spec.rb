require 'spec_helper'

describe "Pisey" do
  describe "Given /stocks" do
    before :each do
      VCR.use_cassette('stocks') do
        get "/stocks"
        @parsed_response = JSON.parse last_response.body
      end
    end

    it "returns an array of hash objects" do
      expect(@parsed_response).to be_an_instance_of Array
      expect(@parsed_response.first).to be_an_instance_of Hash
    end

    it "returns a list of all the stocks" do
      expected = Set.new Mapper::MAPPING.values
      in_data = Set.new @parsed_response.first.keys
      expect(expected.subset? in_data).to be_true
    end
  end

  describe "Given /stocks/:id" do
    before :each do
      VCR.use_cassette('stocks') do
        get "/stocks/bdo"
        @parsed_response = JSON.parse last_response.body
      end
    end

    it "returns a hash object" do
      expect(@parsed_response).to be_an_instance_of Hash
    end

    it "returns a stock given the id" do
      @parsed_response["symbol"].should eq("BDO")
    end

    it "returns volume, percent_change, last_trade_price, name, symbol" do
      expected = Set.new Mapper::MAPPING.values
      in_data = Set.new @parsed_response.keys
      expect(expected.subset? in_data).to be_true
    end
  end

end

