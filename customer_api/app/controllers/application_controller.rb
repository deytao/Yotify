require 'http'

class ApplicationController < ActionController::API
  def http_auth
    HTTP.auth('Bearer %s' % session[:api_access_token])
  end
end
