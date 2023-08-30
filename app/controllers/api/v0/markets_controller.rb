class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(Market.find(params[:id]))
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: "Market not found" }, status: :not_found
  end
end