require 'spec_helper'

describe Pisey do
  include Rack::Test::Methods
  describe "Given /stocks" do
    it "returns json object" do
      get "/stocks"
      raise last_response.body.to_json
      expect(last_response).to be_ok
    end

    it "returns a list of all the stocks"
  end

  describe "Given /stocks?symbol=:id" do
    it "returns a json object"
    it "returns a stock given the id"
    it "returns volume, percent_change, last_trade_price, name, symbol"
  end

end

