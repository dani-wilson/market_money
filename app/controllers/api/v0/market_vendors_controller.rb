class Api::V0::MarketVendorsController < ApplicationController
  before_action :find_market, only: :index

  def find_market 
    @market = Market.find(params[:market_id])
  end

  def index
    render json: VendorSerializer.new(@market.vendors)
  end

  def new
  end

  def create
    MarketVendor.create!(market_vendor_params)
    render json: { "message": "Successfully added vendor to market."}, status: 201
  end

  def destroy
    market_vendor = MarketVendor.find_by(market_id: market_vendor_params[:market_id], vendor_id: market_vendor_params[:vendor_id])
    render json: market_vendor.destroy, status: 204
  end

  private
  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end