class PortfoliosController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_portfolio, only: [:show]

  # GET /portfolios/1
  def show
    render json: @portfolio
  end

  # GET /customers/1/portfolios
  def from_customer
    filters = {
     enabled: true,
     customer_id: params[:id],
    }
    @portfolios = Portfolio.where(filters)

    render json: @portfolios
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end
end
