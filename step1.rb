require 'net/http'
require 'uri'
require 'json'

uri = URI('http://challenge.code2040.org/api/register')

request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
request.body = {token: '641d2efd555c4fd6426096e66b040e8d', github: 'https://github.com/josereyesjrz/Code2040TA'}.to_json

response = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(request)
end
