class CustomersController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /customers
  def index
    @customers = Customer.all

    render json: @customers
  end

  # GET /customers/1
  def show
    @customer = Customer.find(params[:id])
    render json: @customer
  end
end
