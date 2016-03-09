require 'net/http'
require 'rubygems'
require 'json'
require 'pry'

@host = 'battle.platform45.com'
@port = '80'

registration_path = '/register'
# nuke_path = '/nuke'

registration_json = {
  'name': 'name',
  'email': 'email@gmail.com'
}.to_json

# nuke_json = {
#  'id' => '4000',
#  'x' => rand(10).to_s,
#  'y' => rand(10).to_s
# }.to_json

def post(path: '/nuke', payload:)
  req = Net::HTTP::Post.new(path)
  req.body = payload
  response = Net::HTTP.new(@host, @port).start { |http| http.request(req) }
  json_body = JSON.parse(response.body)
 # puts json_body.class
  puts json_body["id"]
  puts "Response #{response.code} #{response.message}:
  #{response.body}"
  binding.pry
end

post(path: registration_path, payload: registration_json)
# post(path: nuke_path, payload: nuke_json)
