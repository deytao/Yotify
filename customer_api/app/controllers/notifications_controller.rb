class NotificationsController < ApplicationController
  def index
    url = '%scustomers/%%s/notifications' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % current_user["customer_id"])
    data = JSON.parse response.body
    render json: data
  end
end
