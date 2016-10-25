require 'net/http'
require 'uri'
require 'json'
require 'time'

uri = URI('http://challenge.code2040.org/api/dating') # Parse challenge URI

request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json') # Create request
request.body = {token: '641d2efd555c4fd6426096e66b040e8d'}.to_json # JSON on body with token

response = Net::HTTP.start(uri.hostname, uri.port) do |http| # Save response
  http.request(request) # Send request
end

jbody = JSON.parse(response.body) # parse to JSON

time = Time.parse(jbody["datestamp"]) # save timestamp

newTime = time + jbody["interval"] # compute new time

uri = URI('http://challenge.code2040.org/api/dating/validate') # Parse validation URI

request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
request.body = {token: '641d2efd555c4fd6426096e66b040e8d', datestamp: newTime.iso8601}.to_json # format newTime to ISO 8601

response = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(request)
end