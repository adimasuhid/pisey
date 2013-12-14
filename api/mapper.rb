require 'open-uri'
require 'json'

class Mapper
  include OpenURI
  attr_accessor :stocks, :stock

  DEFAULT_URL = "http://pse.com.ph/stockMarket/home.html?method=getSecuritiesAndIndicesForPublic"

  def initialize
    self.stocks = open(DEFAULT_URL).read
  end

  def parse
    begin
      stocks = JSON.parse stocks
      true
    rescue
      false
    end
  end
end
