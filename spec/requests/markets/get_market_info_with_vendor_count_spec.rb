require "rails_helper"

RSpec.describe "the markets index page" do
  it "should display the markets' main attributes" do

    query_params = {
      name: "14&U Farmers' Market",
      street: "1400 U Street NW ",
      city: "Washington",
      county: "District of Columbia",
      state: "District of Columbia",
      zip: "20009",
      lat: "38.9169984",
      lon: "-77.0320505"
    }

    get "/api/v0/markets"

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json; charset=utf-8")

    market = JSON.parse(response.body, symbolize_names: true)

    expect(market).to be_a Hash
    expect(market).to have_key(:name)
    expect(market[:name]).to be_a(String)
    expect(market).to have_key(:street)
    expect(market[:street]).to be_a(String)
    expect(market).to have_key(:city)
    expect(market[:city]).to be_a(String)
    expect(market).to have_key(:county)
    expect(market[:county]).to be_a(String)
    expect(market).to have_key(:state)
    expect(market[:state]).to be_a(String)
    expect(market).to have_key(:zip)
    expect(market[:zip]).to be_a(String)
    expect(market).to have_key(:lat)
    expect(market[:lat]).to be_a(String)
    expect(market).to have_key(:lon)
    expect(market[:lon]).to be_a(String)
  end
end