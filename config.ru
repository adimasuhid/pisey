require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './api/mapper.rb'
require './api/pisey-api.rb'
require './pisey.rb'

set :environment, :development
set :run, false
set :raise_errors, true

run Sinatra::Application

