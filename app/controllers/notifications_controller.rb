class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(user_id: current_user.id).order_desc.page(params[:page]).per Settings.per_page
  end

  def update
    @notification = Notification.find_by id: params[:id]
    @notification.mask_as_read = true
    @notification.save
    render json: @notification
  end

  private
  def notification_params
    params.require(:notification).permit(:user_id, :content, :id, :mask_as_read, :target_id)
  end
end
