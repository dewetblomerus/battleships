require 'net/http'
require 'rubygems'
require 'json'
require 'pry'

# Wraps the Platform45 Battleship API
module Platform45

  def self.register(name:, email:)
    registration_json = {
      'name': name,
      'email': email
    }.to_json

    response = post(path: '/register', message: registration_json)
  end

  def self.nuke(id:, x:, y:)
    nuke_json = {
      'id': id,
      'x': x.to_s,
      'y': y.to_s
    }.to_json

    response = post(path: '/nuke', message: nuke_json)
  end

  def self.post(path:, message:)
    host = 'battle.platform45.com'
    req = Net::HTTP::Post.new(path)
    req.body = message
    response = Net::HTTP.new(host).start { |http| http.request(req) }
    response_to_hash(response)
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
