require 'http'

class ApplicationController < ActionController::API
  def current_user
    url = '%susers/current' % Rails.configuration.api_client["url"]
    response = http_auth.get(url)
    JSON.parse response.body
  end

  def http_auth
    HTTP.auth('Bearer %s' % params[:access_token])
  end
end
