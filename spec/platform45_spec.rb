require 'spec_helper'
require_relative '../platform45'

describe Platform45 do
  before do
    VCR.use_cassette 'register' do
      @register_response = Platform45.register(name: 'Name', email: 'email@gmail.com')
      @nuke_response = Platform45.nuke(id: @register_response[:id], x: 0, y: 0)
    end
  end

  it 'regsiters for a new game' do
    expect(@register_response.class).to eq(Hash)
    expect(@register_response[:code]).to eq("200")
    expect(@register_response[:message]).to eq("OK")
    expect(@register_response[:id]).to match(/\d{4}/)
    expect(@register_response[:x]).to be_between(0, 10).inclusive
    expect(@register_response[:y]).to be_between(0, 10).inclusive
  end

  it 'fires nukes' do
    expect(@nuke_response.class).to eq(Hash)
    expect(@nuke_response[:code]).to eq("200")
    expect(@nuke_response[:message]).to eq("OK")
    expect(@nuke_response[:status]).to eq("miss" || "hit")
    expect(@nuke_response[:x]).to be_between(0, 10).inclusive
    expect(@nuke_response[:y]).to be_between(0, 10).inclusive
  end
end

