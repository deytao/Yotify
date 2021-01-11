class UserController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /users/1
  def show
    @user = User.find(params[:id])
    render json: @user
  end

end
