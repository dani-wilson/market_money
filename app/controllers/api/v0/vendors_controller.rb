class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :validation_error
  
  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def new
  end

  def create
    render json: VendorSerializer.new(Vendor.create!(new_vendor_params)), status: 201
  end

  private
  def new_vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end