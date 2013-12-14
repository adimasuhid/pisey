require 'open-uri'
require 'json'

class Mapper
  include OpenURI
  class ::CannotReachURLException < Exception; end;

  attr_accessor :stocks

  DEFAULT_URL = "http://pse.com.ph/stockMarket/home.html?method=getSecuritiesAndIndicesForPublic"
  MAPPING = {
    "totalVolume" => "volume",
    "percChangeClose" => "percent_change",
    "lastTradedPrice" => "last_trade_price",
    "securityAlias" => "name",
    "securitySymbol" => "symbol"
  }

  def initialize
    self.stocks = open(DEFAULT_URL).read
    setup
  end

  def setup
    if parse
      rehash
      true
    else
      raise CannotReachURLException
    end
  end

  def parse
    begin
      self.stocks = JSON.parse(stocks).tap{|stocks| stocks.shift}
      true
    rescue
      false
    end
  end

  def rehash
    self.stocks = stocks.map do |stock|
      Hash[ MAPPING.map{|k,v| [v, stock[k]]} ]
    end
  end

  def all
    self.stocks
  end

  def find(sec_symbol)
    self.stocks.detect{|stock| stock["symbol"] == sec_symbol}
  end
end
