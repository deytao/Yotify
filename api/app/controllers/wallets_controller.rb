class WalletsController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /portfolios/1/wallet
  def from_portfolio
    filters = {
     enabled: true,
     portfolio_id: params[:id],
    }
    @wallet = Wallet.where(filters)

    render json: @wallet
  end

end
