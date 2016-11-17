class ExamsController < ApplicationController
	before_action :find_exam, only: [:show, :edit, :update, :destroy]

  def index
  	@exams = Exam.all
  end

  def show
  	@course = Course.find_by(params[:id])
    @exam = Exam.find_by(id: @course)
  	@exam_result = UserExamResult.new
  	@user = User.find_by(id: current_user.id)
  	puts @user
  end

  def new
  	@exam = Exam.new
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
    	redirect_to exams_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create_user_answer
    grading = params[:answer]
    @correct = 0
    grading.each do |grading|
      find_question(grading[0])
      find_answer(grading[1])
      if @answer == @question.answer
        @correct += 1
      end
    end

    record = ((@correct.to_f/params[:answer].count)*100).round

    if check_for_exam(current_user.id, @exam)
      if @users_exam.score < record
        @users_exam.update(score: record)
        @users_exam.attempts += 1
        @users_exam.save
      else
        @users_exam.attempts += 1
        @users_exam.save
      end
    elsif @users_exam.blank?
      @score = UserExamResult.new(exam_id: @exam, user_id: current_user.id, score: record)
      if @score.save
        @success = "You successfully submitted your exam!"
        update_attempt
      else
        @success = "Uh Oh! something went wrong"
      end
    end

    # Assertion generator
    if @score.score >= 85.00
      recipient = { type: "email", identity: current_user.email, hashed: false }
      @badge = Badge.find_by(course_id: @course)
      badge = "http://frozen-dawn-78535.herokuapp.com/badges/#{@badge}"
      Assertion.create(user_id: current_user.id, badge_id: @badge, recipient: recipient, badge: badge, issued_on: DateTime.now, expires: DateTime.now + 2.years)
    else
      redirect_to dashboard_index_path
      @notice = "Sorry, you did not pass the exam. Please try again!"
    end
  end

  private

  def find_exam
  	@exam = Exam.find_by(params[:id])
  end

  def exam_params
    params.require(:exam).permit(:course_id, :title)
  end

  def find_question(id)
    @question = Question.find(id)
  end

  def find_answer(id)
    @answer = Answer.find(id).content
  end

  def update_attempt
    @update = UserExamResult.last
    @update.update(attempts: + 1)
  end

  def check_for_exam(user,exam)
    @users_exam =  UserExamResult.find_by(exam_id: exam.to_i, user_id: user)
  end
end
