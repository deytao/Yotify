class PositionsController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /portfolios/1/positions
  def from_portfolio
    filters = {
     enabled: true,
     portfolio_id: params[:id],
    }
    @positions = Position.where(filters)

    render json: @positions
  end

end
