class Api::V0::MarketsSearchController < ApplicationController
  before_action :validate_params, only: :index

  def index
    @markets = MarketsFacade.search_markets(params[:name], params[:city], params[:state])
    render json: MarketSerializer.new(@markets)
  end

  private

  def validate_params
    if search_city? || search_city_and_name?
      params_invalid_response
    end
  end

  def search_city?
    params[:city].present? && !params[:name].present? && !params[:state].present?
  end

  def search_city_and_name?
    params[:city].present? && params[:name].present? && !params[:state].present?
  end

  def params_invalid_response
    error_object = Error.new("Invalid parameters.", 422)
    render json: ErrorSerializer.serialize_json(error_object), status: 422
  end
end