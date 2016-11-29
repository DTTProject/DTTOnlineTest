class NotesController < ApplicationController
  before_action :authenticate_user!

  def new
    @test =  Test.find_by id: params[:test_id]
  end

  def create
    @note = current_user.notes.build note_params
    respond_to do |format|
      if @note.save
        format.json do
          render json: @note, status: :created
        end
      else
        format.json do
          render json: @note.errors, status: :unprocessable
        end
      end
    end
  end

  private
  def note_params
    params.require(:note).permit :test_id, :user_id, :week_id, :content
  end
end
