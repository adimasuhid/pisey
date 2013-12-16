require 'sinatra'
require File.join(File.dirname(__FILE__), '..', 'pisey.rb')
require File.join(File.dirname(__FILE__), '../api', 'mapper.rb')
require File.join(File.dirname(__FILE__), '../api', 'pisey-api.rb')

require 'rack/test'
require 'rspec'
require 'vcr'


set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes/"
  c.hook_into :webmock
end

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

