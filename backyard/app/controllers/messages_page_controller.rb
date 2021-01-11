
class MessagesPageController < ApplicationController
  def index
    response = http_auth.get('http://localhost:3000/messages')
    if response.code == 401
      redirect_to "/", info: "Session expired."
    else
      @messages = JSON.parse response.body
    end
  end

  def new
  end

  def create
    payload = {
      subject: params[:subject],
      body: params[:body],
    }
    response = http_auth.post('http://localhost:3000/messages', :json => payload)
    if response.status.success?
      redirect_to "/messages/"
    elsif response.code == 401
      redirect_to "/", info: "Session expired."
    else
      redirect_to "/messages/new", error: "Fail to create message"
    end
  end

  def show
  end
end
