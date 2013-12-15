require 'open-uri'
require 'json'

before do
  content_type :json
  response['Access-Control-Allow-Origin'] = '*'
end

get '/' do
  eval($config.default_error_message).to_json
end

get '/stocks' do
  @mapper = Mapper.new

  @mapper.all.to_json
end

get '/stocks/:id' do
  @mapper = Mapper.new
  (@mapper.find(params[:id].upcase) || {error: "No Such Stock"}).to_json
end
