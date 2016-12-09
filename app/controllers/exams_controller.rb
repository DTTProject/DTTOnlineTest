class ExamsController < ApplicationController
  include LoadBestUsersTest
  before_action :authenticate_user!
  before_action :load_exam

  def create
    exam_datas = []
    test_id = params[:exam][:test_id]
    params[:exam][:user_ids].each do |user_id|
      exam_datas << {
        start_time: Time.now,
        end_time: Time.now,
        status: :start,
        test_type: :challenge,
        test_id: test_id,
        user_id: user_id
      }
    end
    @exams = Exam.create! exam_datas
    @exams.each_with_index do |exam, index|
      exam.create_result_for_challenge current_user, test_id
      Notification.create_notifications params[:exam][:user_ids][index], current_user, exam.id
    end
  end

  def show
    if @exam.start? || @exam.examing?
      caculate_time @exam
    end
    if @exam.start?
      @exam.update_attributes  status: :examing
    end
    load_best_users_test @exam.test.week

  end

  def update
    @exam.end_time = Time.now.to_i
    if @exam.update_attributes exam_params
      if @exam.finished?
        @exam.score =  caculate_score @exam
        @exam.save
        flash[:success] = t "page.tests.do.finished_success"
        redirect_to exam_path @exam
      else
        flash[:success] = t "page.tests.do.save_success"
        redirect_to exams_week_path(@exam.test.week)
      end
    else
      flash[:danger] = t "page.tests.do.save_fail"
      redirect_to :back
    end
  end

  private
  def exam_params
    params.require(:exam).permit(
      :id, :user_id, :test_id,
      :status, :start_time,
      :endtime, :score,
      results_attributes: [:id, :question_id, :exam_id, :answer_id]
    )
  end

  def caculate_time exam
    @spend_time = exam.end_time -  exam.start_time
    @time = exam.test.week.course.duration.to_i * Settings.MINUTE - @spend_time
    @hour = @time / 3600
    @minute = (@time % 3600) / 60
    @second = (@time % 3600) % 60
  end

  def caculate_score exam
    (exam.results.is_corrects.count).to_s + "/" + (exam.test.week.course.question_numbers).to_s
  end

  def load_exam
    @exam = Exam.includes([:test]).find_by id: params[:id]
  end
end

