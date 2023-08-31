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
    @market = Market.find(params[:market_id])
    @vendor = Vendor.find(params[:id])
    new_market_vendor = MarketVendor.create(@market.id, @vendor.id)
    render json: MarketVendorSerializer.new(@market, @vendor)
  end
end