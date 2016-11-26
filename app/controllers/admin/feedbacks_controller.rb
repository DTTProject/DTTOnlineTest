class Admin::FeedbacksController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :check_if_admin

  def index
    @feedbacks =  Feedback.order_desc.page(params[:page]).per Settings.per_page
  end

  def update
    @feedback =  Feedback.find_by id: params[:id]
    if @feedback.update_attributes response: 1
      render json: @feedback, status: :ok
    end
  end

end
