require "rails_helper"

RSpec.describe "vendor requests" do
  describe "the vendor show page" do
    it "can get one vendor" do
      id = create(:vendor).id
      vendor_1 = create(:vendor)

      get "/api/v0/vendors/#{id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to have_key(:data)
      expect(data.count).to eq(1)
      
      vendor = data[:data]
      
      expect(vendor).to be_a(Hash)

      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_an(String)

      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to eq("vendor")

      expect(vendor).to have_key(:attributes)
      expect(vendor[:attributes]).to be_a(Hash)

      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to be_a(String)

      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to be_in([true, false])
    end

    it "will throw an error message when an invalid vendor id is passed in" do
      id = create(:vendor).id
      vendor_1 = create(:vendor)

      get "/api/v0/vendors/30"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      vendor = JSON.parse(response.body, symbolize_names: true)

      expect(vendor[:errors][0][:details]).to eq("Couldn't find Vendor with 'id'=30")
    end
  end

  it "can create a new vendor" do
    new_vendor_params = ({
      name: "Neapolitan Thalassa Fish",
      description: "Gave me cookie got you cookie!",
      contact_name: "Hershel Smith CPA",
      contact_phone: "480-465-1742",
      credit_accepted: true
    })

    post "/api/v0/vendors", params: {vendor: new_vendor_params}

    created_vendor = Vendor.last

    expect(created_vendor.name).to eq(new_vendor_params[:name])
    expect(created_vendor.description).to eq(new_vendor_params[:description])
    expect(created_vendor.contact_name).to eq(new_vendor_params[:contact_name])
    expect(created_vendor.contact_phone).to eq(new_vendor_params[:contact_phone])
    expect(created_vendor.credit_accepted).to eq(new_vendor_params[:credit_accepted])

    expect(response).to be_successful
    expect(response.status).to eq(201)
    
    new_vendor = JSON.parse(response.body, symbolize_names: true)

    expect(new_vendor[:data]).to have_key(:type)
    expect(new_vendor[:data][:type]).to eq("vendor")

    expect(new_vendor[:data]).to have_key(:attributes)
    expect(new_vendor[:data][:attributes]).to be_a(Hash)

    attributes = new_vendor[:data][:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_a(String)

    expect(attributes).to have_key(:contact_name)
    expect(attributes[:contact_name]).to be_a(String)

    expect(attributes).to have_key(:contact_phone)
    expect(attributes[:contact_phone]).to be_a(String)

    expect(attributes).to have_key(:credit_accepted)
    expect(attributes[:credit_accepted]).to be_in([true, false])
  end

  it "will return a 400 status code if information is missing" do
    new_vendor_params = ({
      name: "Neapolitan Thalassa Fish",
      contact_name: "Hershel Smith CPA",
      contact_phone: "480-465-1742",
      credit_accepted: true
    })

    post "/api/v0/vendors", params: {vendor: new_vendor_params}

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    vendor = JSON.parse(response.body, symbolize_names: true)
    expect(vendor[:errors][0][:details]).to eq("Validation failed: Description can't be blank")
  end

  it "testing my boolean just for fun" do
    new_vendor_params = ({
      name: "Neapolitan Thalassa Fish",
      description: "Gave me cookie got you cookie!",
      contact_name: "Hershel Smith CPA",
      contact_phone: "480-465-1742"
    })

    post "/api/v0/vendors", params: {vendor: new_vendor_params}

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    vendor = JSON.parse(response.body, symbolize_names: true)
    expect(vendor[:errors][0][:details]).to eq("Validation failed: Credit accepted can't be blank, Credit accepted is not included in the list")
  end

  it "can update a vendor" do
    
  end
end