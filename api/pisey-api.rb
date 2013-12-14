require 'open-uri'
require 'json'

get '/' do
  $config.default_error_message
end

get '/stocks' do
  content_type :json

  {response: 200}.to_json
end

get '/proxy.json' do
  content_type :json

  data  = open('http://tl.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&titles=Article&generator=random').read
  parsed_data = JSON.parse data
  content = parsed_data["query"]["pages"].first.last

  { title: content["title"], content: content["extract"]}.to_json
end
