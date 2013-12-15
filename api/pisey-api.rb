require 'open-uri'
require 'json'

get '/' do
  $config.default_error_message
end

get '/stocks' do
  content_type :json
  @mapper = Mapper.new

  @mapper.all.to_json
end

get '/stocks/:id' do
  content_type :json

  @mapper = Mapper.new
  (@mapper.find(params[:id].upcase) || {error: "No Such Stock"}).to_json
end
