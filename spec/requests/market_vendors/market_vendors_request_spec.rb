require "rails_helper"

RSpec.describe "the market vendors index page" do
  it "can get all vendors of a specific market" do
    market_1 = create(:market)

    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    MarketVendor.create!(market: market_1, vendor: vendor_1)
    MarketVendor.create!(market: market_1, vendor: vendor_2)
    MarketVendor.create!(market: market_1, vendor: vendor_3)

    get "/api/v0/markets/1/vendors"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:data)

    vendors = data[:data]
    expect(vendors).to be_an(Array)
    expect(vendors.count).to eq(3)
    expect(vendors.count).to eq(market_1.vendor_count)

    vendors.each do |vendor|
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_an(String)

      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to eq("vendor")

      expect(vendor).to have_key(:attributes)
      expect(vendor[:attributes]).to be_a(Hash)

      attributes = vendor[:attributes]

      keys = [:name, :description, :contact_name, :contact_phone]
        keys.each do |key|
        expect(attributes).to have_key(key)
        expect(attributes[key]).to be_a(String)

        expect(attributes).to have_key(:credit_accepted)
        expect(attributes[:credit_accepted]).to be_in([true, false])
        expect(attributes.length).to eq(5)
      end
    end
  end

  it "will throw an error message when an invalid id is passed in" do
    market_1 = create(:market)

    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    MarketVendor.create!(market: market_1, vendor: vendor_1)
    MarketVendor.create!(market: market_1, vendor: vendor_2)
    MarketVendor.create!(market: market_1, vendor: vendor_3)

    get "/api/v0/markets/20/vendors"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    market = JSON.parse(response.body, symbolize_names: true)
    
    expect(market[:errors][0][:title]).to eq("Couldn't find Market with 'id'=20")
  end

  it "can create a new marketvendor" do
    market_1 = create(:market)

    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    MarketVendor.create!(market: market_1, vendor: vendor_1)
    MarketVendor.create!(market: market_1, vendor: vendor_2)
    MarketVendor.create!(market: market_1, vendor: vendor_3)

    post "/api/v0/market_vendors"

    
  end
end