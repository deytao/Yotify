require 'http'

class SigninPageController < ApplicationController
  def form
  end

  def validate
    payload = {
      grant_type: :password,
      email: params[:email],
      password: params[:password],
    }
    response = HTTP.post('http://localhost:3000/oauth/token', :json => payload)
    if response.status.success?
      data = JSON.parse response.body
      session[:api_access_token] = data["access_token"]
      redirect_to "/messages/"
    else
      redirect_to "/"
    end
  end
end
