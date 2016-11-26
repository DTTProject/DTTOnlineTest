class FeedbacksController < ApplicationController

  def create
    @feedback =  Feedback.new feedback_params
    respond_to do |format|
      if @feedback.save
        format.html do
          flash[:success] = t "page.feedbacks.success"
          redirect_to root_path
        end
        format.js
      else
        format.html do
          flash[:error] = @feedback.errors.full_messages.to_sentence
        end
        format.js{ render status: 500 }
      end
    end
  end

  private
  def feedback_params
    params.require(:feedback).permit :name, :email, :content, :response
  end
end
