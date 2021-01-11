
class MessagesPageController < ApplicationController
  def index
    response = http_auth.get('http://localhost:3000/messages')
    if response.code == 401
      redirect_to "/", info: "Session expired."
    else
      @messages = JSON.parse response.body
      users = {}
      @messages.each do |message|
        user_id = message.delete("user_id")
        unless users.key?(user_id)
          response = http_auth.get('http://localhost:3000/users/%s' % user_id)
          users[user_id] = JSON.parse response.body
        end
        user = users[user_id]
        message["user_fullname"] = "%s %s" % [user["firstname"], user["lastname"]]
      end
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
