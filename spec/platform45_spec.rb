require_relative '../platform45'
describe Platform45 do
  let(:platform45) { Platform45.new }

  it 'regsiters for a new game' do
    response = Platform45.register
    expect(response.class).to eq(Hash)
    expect(response[:code]).to eq("200")
    expect(response[:message]).to eq("OK")
    expect(response[:id]).to match(/\d{4}/)
    expect(response[:x]).to be_between(1, 10).inclusive
    expect(response[:y]).to be_between(1, 10).inclusive
  end
end

