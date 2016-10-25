require 'net/http'
require 'uri'
require 'json'

uri = URI('http://challenge.code2040.org/api/prefix') # Parse challenge URI

request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json') # Create request
request.body = {token: '641d2efd555c4fd6426096e66b040e8d'}.to_json # JSON on body with token

response = Net::HTTP.start(uri.hostname, uri.port) do |http| # Save response
  http.request(request) # Send request
end

jbody = JSON.parse(response.body) # parse to JSON

jarray = Array.new # array with strings without prefix

jbody["array"].each_with_index do |string, i| # iterate over given array
	jarray << jbody["array"][i] unless jbody["array"][i].start_with?(jbody["prefix"]) # only push to new array if string doesn't have prefix
end

uri = URI('http://challenge.code2040.org/api/prefix/validate') # Parse validation URI

request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
request.body = {token: '641d2efd555c4fd6426096e66b040e8d', array: jarray}.to_json

response = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(request)
end