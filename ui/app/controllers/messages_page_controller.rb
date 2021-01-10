require 'http'

class MessagesPageController < ApplicationController
  def index
    response = HTTP.auth('Bearer %s' % session[:api_access_token]).get('http://localhost:3000/messages')
    render plain: response.body
  end
end
