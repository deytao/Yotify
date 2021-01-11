require 'http'

class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning

  def http_auth
    HTTP.auth('Bearer %s' % session[:api_access_token])
  end
end
