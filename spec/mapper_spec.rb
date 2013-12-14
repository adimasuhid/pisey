require 'spec_helper'
require 'set'

describe 'Mapper' do
  context "unstubbed setup" do
    describe "#setup" do
      it "returns an error if url is invalid" do
        stub_const("Mapper::DEFAULT_URL", "")
        expect{Mapper.new}.to raise_exception
      end

      it "returns true if setup succeeds" do
        VCR.use_cassette('stocks') do
          Mapper.new.should be_true
        end
      end
    end
  end

  context "stubbed setup" do
    before :each do
      Mapper.any_instance.stub(:setup => 'true')
      VCR.use_cassette('stocks') do
        @mapper = Mapper.new
      end
    end

    describe "#parse" do
      it "parses string to a hash" do
        @mapper.stocks.should be_an_instance_of String
        @mapper.parse
        @mapper.stocks.should be_an_instance_of Array
      end

      it "removes the first entry" do
        initial = JSON.parse(@mapper.stocks).first
        @mapper.parse
        mapped = @mapper.stocks.first
        initial.should_not eq(mapped)
      end

      it "returns true if successfully parsed" do
        @mapper.parse.should be_true
      end

      it "returns false if error occured" do
        @mapper.stocks = ""
        @mapper.parse.should be_false
      end
    end

    describe "#rehash" do
      before :each do
        @mapper.parse
      end

      it "maps data into ruby-esque column names" do
        @mapper.rehash
        expected = Set.new Mapper::MAPPING.values
        in_data = Set.new @mapper.stocks.first.keys
        expect(expected.subset? in_data).to be_true
      end
    end

    describe "#find" do
      before :each do
        @mapper.parse
        @mapper.rehash
      end

      it "returns hash object of given stock" do
        @mapper.find("BDO").should be_an_instance_of Hash
        @mapper.find("BDO")["symbol"].should == "BDO"
      end

      it "returns volume, percent_change, last_trade_price, name, symbol" do
        expected = Set.new Mapper::MAPPING.values
        in_data = Set.new @mapper.find("BDO").keys
        expect(expected.subset? in_data).to be_true
      end

      it "returns nil when none is found" do
        @mapper.find("LALALA").should be_nil
      end
    end

    describe "#all" do
      before :each do
        @mapper.parse
        @mapper.rehash
      end

      it "returns an array of hash objects with stocks" do
        @mapper.all.should be_an_instance_of Array
        @mapper.all.first.should be_an_instance_of Hash
      end
    end

  end
end
