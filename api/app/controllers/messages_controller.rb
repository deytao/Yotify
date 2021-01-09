class MessagesController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_message, only: [:show, :update]

  # GET /messages
  def index
    @messages = Message.where(enabled: true)

    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @messages
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.enabled = false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.where(enabled: true, id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:subject, :body)
    end
end
