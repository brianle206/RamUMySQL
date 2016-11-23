class ExamsController < ApplicationController
	before_action :find_exam, only: [:show, :edit, :update, :destroy]

  def index
  	@exams = Exam.all
  end

  def show
  	@course = Course.find_by(params[:course_id])
    @exam = Exam.find_by(params[:course_id])
  	@exam_result = UserExamResult.new
  	@user = User.find_by(id: current_user.id)
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
    if @exam.destroy
      redirect_to exams_path
      @notice = 'Exam was successfully deleted!'
    end
  end

  def create_user_answer
    @course = Course.find_by(params[:course_id])

    grade_exam

    record = ((@correct.to_f/params[:answer].count)*100).round

    check_exam_attempts(record)

    generate_assertion
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

  def check_exam_attempts(record)
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
        @notice = "You successfully submitted your exam!"
        update_attempt
      else
        @notice = "Uh Oh! something went wrong"
      end
    end
  end

  def grade_exam
    grading = params[:answer]
    @correct = 0
    grading.each do |grading|
      find_question(grading[0])
      find_answer(grading[1])
      if @answer == @question.answer
        @correct += 1
      end
    end
    puts "Total correct answers: #{@correct}"
    return @correct
  end

  def generate_assertion
    puts @score.score
    if @score.score >= 85.00
      begin
        puts "START UP THE GENERATOR!!!!"
        recipient = { type: "email", identity: current_user.email, hashed: false }
        puts "Recipient: #{recipient}"
        @badge = Badge.find_by(course_id: @course)
        puts "Badge ID: #{@badge.id}"
        badge = "http://frozen-dawn-78535.herokuapp.com/badges/#{@badge.id}"
        puts "Badge: #{badge}"
        @assertion = Assertion.new(user_id: current_user.id, badge_id: @badge.id, recipient: recipient, badge: badge, issued_on: DateTime.now, expires: DateTime.now + 2.years)
        puts "Assertion: #{@assertion.to_json}"
        @assertion[:verify] = { type: "hosted", url: "http://frozen-dawn-78535.herokuapp.com/assertions/#{@assertion.id}" }
        puts "Assertion with verify: #{@assertion.to_json}"
        # @assertion.bake
      rescue => err
        Rails.logger.error "Womp womp, no assertion for you!"
        Rails.logger.error "#{err.message}\n#{err.backtrace.join("\n")}"
      end
    else
      redirect_to dashboard_index_path
      flash[:alert] = "Sorry, you did not pass the exam. Please try again!"
    end

    respond_to do |format|
      if @assertion.save
        session[:assertion_origin] = secret_assertion_path(id: @assertion.id, uid: @assertion.uid)
        format.html { redirect_to dashboard_index_path, notice: "Congratulations! You passed the Exam!" }
        format.json { render :show, status: :created, location: @assertion }
      else
        format.html { redirect_to dashboard_index_path }
        format.json { render json: @assertion.errors, status: :unprocessable_entity }
      end
    end
  end
end
