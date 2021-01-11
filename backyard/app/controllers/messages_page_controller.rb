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
    response = http_auth.get('http://localhost:3000/messages/%s' % params[:id])
    if response.code == 401
      redirect_to "/", info: "Session expired."
    else
      @message = JSON.parse response.body
      response = http_auth.get('http://localhost:3000/customers')
      _customers = JSON.parse response.body
      @customers = {}
      _customers.each do |customer|
        @customers[customer["id"]] = customer
      end
      response = http_auth.get('http://localhost:3000/messages/%s/notifications' % params[:id])
      @notifications = JSON.parse response.body
      @notifications.each do |notification|
        customer_id = notification.delete("customer_id")
        unless @customers.key?(customer_id)
          response = http_auth.get('http://localhost:3000/customers/%s' % customer_id)
          @customers[customer_id] = JSON.parse response.body
        end
        customer = @customers[customer_id]
        notification["customer_name"] = customer["name"]
      end
    end
  end

  def notify
    customer_ids = params[:customer_ids]
    customer_ids.each do |customer_id|
      payload = {
        message_id: params[:id],
        customer_id: customer_id,
        sent_at: DateTime.current,
      }
      http_auth.post('http://localhost:3000/notifications', :json => payload)
    end
    redirect_to url_for(controller: "messages_page", action: "show", id: params[:id])
  end
end
