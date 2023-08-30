require "rails_helper"

RSpec.describe "the markets index page" do
  it "should display the markets' main attributes and vendor count" do
    create_list(:market, 5)
    create_list(:vendor, 15)

    get "/api/v0/markets"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    markets = JSON.parse(response.body, symbolize_names: true)

    expect(markets[:data].count).to eq(5)

    markets[:data].each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_an(String)

      expect(market).to have_key(:type)
      expect(market[:type]).to eq("market")

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a(Hash)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a(String)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a(String)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a(String)

      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a(String)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a(String)

      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a(String)

      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to be_a(String)

      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a(String)

      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_an(Integer)
    end
  end
end

describe "the market show page" do
  it "can get one market" do
    id = create(:market).id
    create_list(:market, 5)
    create_list(:vendor, 15)

    get "/api/v0/markets/#{id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    market = JSON.parse(response.body, symbolize_names: true)

    expect(market.count).to eq(1)

    expect(market[:data]).to have_key(:id)
    expect(market[:data][:id]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:name)
    expect(market[:data][:attributes][:name]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:street)
    expect(market[:data][:attributes][:street]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:city)
    expect(market[:data][:attributes][:city]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:county)
    expect(market[:data][:attributes][:county]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:state)
    expect(market[:data][:attributes][:state]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:zip)
    expect(market[:data][:attributes][:zip]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:lat)
    expect(market[:data][:attributes][:lat]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:lon)
    expect(market[:data][:attributes][:lon]).to be_a(String)

    expect(market[:data][:attributes]).to have_key(:vendor_count)
    expect(market[:data][:attributes][:vendor_count]).to be_an(Integer)
  end

  it "will throw an error message if market id does not exist" do
    get "/api/v0/markets/1"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    market = JSON.parse(response.body, symbolize_names: true)
    expect(market[:errors][0][:details]).to eq("Couldn't find Market with 'id'=1")
  end
end