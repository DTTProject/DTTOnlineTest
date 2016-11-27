class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build comment_params
    respond_to do |format|
      if @comment.save
        format.json{render json: @comment, status: :created}
      else
        format.json{render json: @comment.errors, status: :unprocessable}
      end
    end

  end

  private
  def comment_params
    params.require(:comment).permit :rating, :course_id, :user_id, :content
  end
end

