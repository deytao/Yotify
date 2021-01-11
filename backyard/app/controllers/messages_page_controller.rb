class MessagesPageController < ApplicationController
  def index
    url = '%smessages' % Rails.configuration.api_client["url"]
    response = http_auth.get(url)
    if response.code == 401
      redirect_to "/", info: "Session expired."
    else
      @messages = JSON.parse response.body
      users = {}
      @messages.each do |message|
        user_id = message.delete("user_id")
        unless users.key?(user_id)
          url = '%susers/%%s' % Rails.configuration.api_client["url"]
          response = http_auth.get(url % user_id)
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
    url = '%smessages' % Rails.configuration.api_client["url"]
    response = http_auth.post(url, :json => payload)
    if response.status.success?
      redirect_to "/messages/"
    elsif response.code == 401
      redirect_to "/", info: "Session expired."
    else
      redirect_to "/messages/new", error: "Fail to create message"
    end
  end

  def show
    url = '%smessages/%%s' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % params[:id])
    if response.code == 401
      redirect_to "/", info: "Session expired."
    else
      @message = JSON.parse response.body
      url = '%scustomers' % Rails.configuration.api_client["url"]
      response = http_auth.get(url)
      _customers = JSON.parse response.body
      @customers = {}
      _customers.each do |customer|
        @customers[customer["id"]] = customer
      end
      url = '%smessages/%%s/notifications' % Rails.configuration.api_client["url"]
      response = http_auth.get(url % params[:id])
      @notifications = JSON.parse response.body
      @notifications.each do |notification|
        customer_id = notification.delete("customer_id")
        unless @customers.key?(customer_id)
          url = '%scustomers/%%s' % Rails.configuration.api_client["url"]
          response = http_auth.get(url % customer_id)
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
      url = '%snotifications' % Rails.configuration.api_client["url"]
      http_auth.post(url, :json => payload)
    end
    redirect_to url_for(controller: "messages_page", action: "show", id: params[:id])
  end
end
