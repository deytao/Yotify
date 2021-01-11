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
    url = '%soauth/token' % Rails.configuration.api_client["url"]
    response = HTTP.post(url, :json => payload)
    if response.status.success?
      data = JSON.parse response.body
      session[:api_access_token] = data["access_token"]
      redirect_to "/messages/"
    else
      redirect_to "/", error: "Invalid credentials"
    end
  end
end
