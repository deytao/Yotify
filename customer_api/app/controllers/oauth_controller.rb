require 'http'

class OauthController < ApplicationController
  def token
    payload = {
      grant_type: :password,
      email: params[:email],
      password: params[:password],
    }
    url = '%soauth/token' % Rails.configuration.api_client["url"]
    response = HTTP.post(url, :json => payload)
    data = JSON.parse response.body
    render json: data, status: response.status
  end
end
