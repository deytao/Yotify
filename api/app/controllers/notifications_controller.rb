class NotificationsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_notification, only: [:show, :update, :destroy]

  # GET /notifications
  def index
    filters = {
     enabled: true,
    }
    @notifications = Notification.where(filters)

    render json: @notifications
  end

  # GET /notifications/1
  def show
    status = :not_found unless @notification
    render json: @notification, status: status
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)
    @notification.sent_at = Time.current unless @notification.sent_at

    if @notification.save
      render json: @notification, status: :created, location: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.enabled = false
  end

  # GET /messages/1/notifications
  def from_message
    filters = {
     enabled: true,
     message_id: params[:id],
    }
    @notifications = Notification.where(filters)

    render json: @notifications
  end

  # GET /customers/1/notifications
  def from_customer
    filters = {
     enabled: true,
     customer_id: params[:id],
    }
    @notifications = Notification.where(filters)

    render json: @notifications
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      filters = {
       enabled: true,
       id: params[:id],
      }
      if current_user.customer
        filters[:customer] = current_user.customer
      end
      @notification = Notification.where(filters).first
    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:sent_at, :read_at, :message_id, :customer_id)
    end
end
