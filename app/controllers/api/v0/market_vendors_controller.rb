class Api::V0::MarketVendorsController < ApplicationController
  before_action :find_market, only: :index
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def find_market 
    @market = Market.find(params[:market_id])
  end

  def index
    render json: VendorSerializer.new(@market.vendors)
  end
end