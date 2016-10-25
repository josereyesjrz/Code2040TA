require 'net/http'
require 'uri'
require 'json'

uri = URI('http://challenge.code2040.org/api/haystack') # Parse challenge URI

request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json') # Create request
request.body = {token: '641d2efd555c4fd6426096e66b040e8d'}.to_json # JSON on body with token

response = Net::HTTP.start(uri.hostname, uri.port) do |http| # Save response
  http.request(request) # Send request
end

jbody = JSON.parse(response.body) # parse to JSON

hindex = jbody["haystack"].index(jbody["needle"]) # lookup index of string

uri = URI('http://challenge.code2040.org/api/haystack/validate') # Parse validation URI

request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
request.body = {token: '641d2efd555c4fd6426096e66b040e8d', needle: hindex}.to_json

response = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(request)
end