require 'http'

class OauthController < ApplicationController
  def token
    payload = {
      grant_type: :password,
      email: params[:email],
      password: params[:password],
    }
    url = '%soauth/token' % Rails.configuration.api_client["url"]
    data = JSON.parse HTTP.post(url, :json => payload).body
    render json: data
  end
end
