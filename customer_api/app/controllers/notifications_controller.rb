class NotificationsController < ApplicationController

  # GET /notifications
  def index
    url = '%scustomers/%%s/notifications' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % current_user["customer_id"])
    data = JSON.parse response.body
    render json: data
  end

  # GET /notifications/1
  def show
    url = '%snotifications/%%s' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % params[:id])
    data = JSON.parse response.body
    if data and !data["read_at"]
      payload = {
        read_at: DateTime.current,
      }
      response = http_auth.patch(url % params[:id], json: payload)
      data = JSON.parse response.body
    end
    render json: data, status: response.status
  end
end
