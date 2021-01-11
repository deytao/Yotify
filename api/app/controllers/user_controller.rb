class UserController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /users/1
  # GET /users/current
  def show
    requested_value = params[:id]
    if requested_value == "current"
      render json: current_user
    else
      @user = User.find()
      render json: @user
    end
  end

end
