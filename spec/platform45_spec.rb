require 'spec_helper'
require_relative '../platform45'

describe Platform45 do
  before do
    VCR.use_cassette 'register' do
      @response = Platform45.register
    end
  end

  it 'regsiters for a new game' do
    expect(@response.class).to eq(Hash)
    expect(@response[:code]).to eq("200")
    expect(@response[:message]).to eq("OK")
    expect(@response[:id]).to match(/\d{4}/)
    expect(@response[:x]).to be_between(0, 10).inclusive
    expect(@response[:y]).to be_between(0, 10).inclusive
  end
end

