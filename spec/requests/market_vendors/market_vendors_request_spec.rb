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

    expect(MarketVendor.count).to eq(2)

    market_vendor_params = { 
      market_id: market_1.id,
      vendor_id: vendor_3.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate({market_vendor: market_vendor_params}) 

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(MarketVendor.count).to eq(3)

    get "/api/v0/markets/#{market_1.id}/vendors"

    expect(market_1.vendor_count).to eq(3)
  end

  it "will throw an error if an invalid vendor or market id is passed" do
    market_1 = create(:market)

    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    MarketVendor.create!(market: market_1, vendor: vendor_1)
    MarketVendor.create!(market: market_1, vendor: vendor_2)

    market_vendor_params = { 
      market_id: 47,
      vendor_id: vendor_3.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate({market_vendor: market_vendor_params})

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    market_vendor = JSON.parse(response.body, symbolize_names: true)
    expect(market_vendor[:errors][0][:title]).to eq("Validation failed: Market must exist")

    market_vendor_params = { 
      market_id: market_1.id,
      vendor_id: 87
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate({market_vendor: market_vendor_params})

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    market_vendor = JSON.parse(response.body, symbolize_names: true)
    expect(market_vendor[:errors][0][:title]).to eq("Validation failed: Vendor must exist")
  end

  it "will throw an error if a vendor or market id is NOT passed in" do
    market_1 = create(:market)

    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    MarketVendor.create!(market: market_1, vendor: vendor_1)
    MarketVendor.create!(market: market_1, vendor: vendor_2)

    market_vendor_params = { 
      market_id: "",
      vendor_id: vendor_3.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate({market_vendor: market_vendor_params})

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    market_vendor = JSON.parse(response.body, symbolize_names: true)
    expect(market_vendor[:errors][0][:title]).to eq("Validation failed: Market can't be blank, Market must exist")

    market_vendor_params = { 
      market_id: market_1.id,
      vendor_id: ""
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate({market_vendor: market_vendor_params})

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    market_vendor = JSON.parse(response.body, symbolize_names: true)
    expect(market_vendor[:errors][0][:title]).to eq("Validation failed: Vendor can't be blank, Vendor must exist")
  end

  it "will throw an error if the market or vendor id already exists" do
    market_1 = create(:market)

    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    MarketVendor.create!(market: market_1, vendor: vendor_1)
    MarketVendor.create!(market: market_1, vendor: vendor_2)

    market_vendor_params = { 
      market_id: market_1.id,
      vendor_id: vendor_1.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate({market_vendor: market_vendor_params})

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    
    market_vendor = JSON.parse(response.body, symbolize_names: true)
    expect(market_vendor[:errors][0][:title]).to eq("Validation failed: Market has already been taken")
  end

  it "can delete a marketvendor" do
    market_1 = create(:market)

    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    MarketVendor.create!(market: market_1, vendor: vendor_1)
    MarketVendor.create!(market: market_1, vendor: vendor_2)
    MarketVendor.create!(market: market_1, vendor: vendor_3)

    expect(MarketVendor.count).to eq(3)

    market_vendor_params = ({
      market_id: market_1.id,
      vendor_id: vendor_3.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    delete "/api/v0/market_vendors/", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to be_successful
    expect(response.status).to eq(204)
  end
end