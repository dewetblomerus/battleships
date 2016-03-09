require 'net/http'
require 'rubygems'
require 'json'
require 'pry'

# Wraps the Platform45 Battleship API
class Platform45
  @host = 'battle.platform45.com'
  @port = '80'

  def self.register
    registration_path = '/register'

    registration_json = {
      'name': 'name',
      'email': 'email@gmail.com'
    }.to_json

    response = post(path: registration_path, payload: registration_json)

    response_to_hash(response)
  end

  def nuke
    # nuke_path = '/nuke'

    # nuke_json = {
    #   'id': '4000',
    #   'x': rand(10).to_s,
    #   'y': rand(10).to_s
    # }.to_json
  end

  def self.post(path: '/nuke', payload:)
    req = Net::HTTP::Post.new(path)
    req.body = payload
    response = Net::HTTP.new(@host, @port).start { |http| http.request(req) }
    response
  end

  def self.response_to_hash(response)
    json_body = JSON.parse(response.body)
    json_body = json_body.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    response_hash = {
      code: response.code,
      message: response.message,
    }
    response_hash.merge(json_body)
  end
end
