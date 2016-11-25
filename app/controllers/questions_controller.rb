class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_best_users
  before_action :load_courses, only: [:new, :create, :edit]
  before_action :load_question, except: :index

  def index
    @questions = current_user.questions
      .page(params[:page]).per Settings.per_page
  end

  def show
  end

  def new
    @question = Question.new
    @question.answers.build
  end

  def create
    @question  = current_user.questions.build question_params
    respond_to do |format|
       if @question.save
        format.html do
          flash[:success] = t "page.admin.questions.new.success"
          redirect_to questions_path
        end
        format.json do
          render json: @question, status: 200
        end
       else
        format.html do
          flash[:error] = t "page.admin.questions.new.error"
          # flash[:error] = @question.errors.full_messages.to_sentence
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
      if current_user.questions.update question_params
        format.html do
          flash[:success] =  t "page.admin.questions.edit.success"
          redirect_to questions_path
        end
      else
        format.html do
          flash[:success] =  t "page.admin.questions.edit.error"
          render action: :edit
        end
      end
    end
  end

  private
  def question_params
    params.require(:question). permit(
      :id, :status, :user_id,
      :course_id, :content,
      :suggestion, :complexity,
      answers_attributes: [:id, :content, :correct, :question_id, :_destroy]
    )
  end

  def load_courses
    @courses =  Course.all
  end

  def load_question
    @question =  Question.includes(:course).find_by id: params[:id]
  end

  def load_best_users
    @users = User.send(:best_user_hash)
  end
end
