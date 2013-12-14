require 'spec_helper'

describe 'Pisey' do
  describe "Given /stocks" do
    it "returns a list of all the stocks"
    it "returns json object"
  end

  describe "Given /stocks?symbol=:id" do
    it "returns a json object"
    it "returns a stock given the id"
    it "returns volume, percent_change, last_trade_price, name, symbol"
  end

end

