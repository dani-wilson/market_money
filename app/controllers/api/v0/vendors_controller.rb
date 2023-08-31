class Api::V0::VendorsController < ApplicationController

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def new
  end

  def create
    render json: VendorSerializer.new(Vendor.create!(vendor_params)), status: 201
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
    render json: VendorSerializer.new(vendor)
    else 
      error = Error.new("Validation failed", 400)
      render json: ErrorSerializer.serialize_json(error)
    end
  end

  private
  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end