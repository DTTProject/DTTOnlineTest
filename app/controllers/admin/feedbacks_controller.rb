class Admin::FeedbacksController < ApplicationController
  layout "admin"
  before_action :set_feedback, except: :index

  def index
    @feedbacks = Feedback.all
  end

  def show
  end

  def edit
  end

  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      redirect_to root_path, notice: t("feedback.successfully_created")
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /feedbacks/1
  def update
    if @feedback.update(feedback_params)
      redirect_to admin_feedbacks_path, notice: t("feedback.successfully_updated")
    else
      render :edit
    end
  end

  # DELETE /feedbacks/1
  def destroy
    @feedback.destroy
    flash[:notice] = t "feedback.successfully_destroyed"
  end

  private
  def set_feedback
    @feedback = Feedback.find_by id: params[:id]
  end

  def feedback_params
    params.require(:feedback).permit(:name, :email, :content, :response)
  end
end
