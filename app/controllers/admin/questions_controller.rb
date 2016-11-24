class Admin::QuestionsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :check_if_admin
  before_action :load_courses
  before_action :load_question, only: [:edit, :update, :destroy]
  def index
    @questions = Question.includes(:course).page(params[:page]).per Settings.per_page
  end

  def new
    @question = Question.new
    @question.answers.build
  end

  def create
    @question  = Question.new question_params
    respond_to do |format|
       if @question.save
        format.html do
          flash[:success] = t "page.admin.questions.new.success"
          redirect_to admin_questions_path
        end
        format.json do
          render json: @question, status: 200
        end
       else
        format.html do
          flash[:error] = t "page.admin.questions.new.error"
          render action: :new
        end
        format.json do
          render json: @question.errors, status: :unprocessable_entity
        end
       end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @question.update question_params
        format.html do
          flash[:success] =  t "page.admin.questions.edit.success"
          redirect_to admin_questions_path
        end
      else
        format.html do
          flash[:success] =  t "page.admin.questions.edit.error"
          render action: :edit
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @question.results.count > 0
        @message = t "page.admin.questions.destroy.fail"
        format.html do
          flash[:warning] =  @message
          redirect_to :back
        end
        format.json do
          render json: {warning: {message: @message}}
        end
      else
        @question.destroy
        format.html do
          redirect_to admin_questions_path,
            success: t("page.admin.questions.destroy.success")
        end
        format.json do
          render json: {id: params[:id], status: :ok}
        end
      end
    end
  end

  private
  def question_params
    params.require(:question). permit(
      :id, :status,
      :course_id, :content,
      :suggestion, :complexity,
      answers_attributes: [:id, :content, :correct, :question_id, :_destroy]
    )
  end

  def load_courses
    @courses =  Course.all
  end

  def load_question
    @question =  Question.find_by id: params[:id]
  end
end
