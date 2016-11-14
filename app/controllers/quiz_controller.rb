class QuizController < ApplicationController
  def index
    @courses = Learn.all
  end

  def new
    @quiz = Quiz.new
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update(quiz_params)
      redirect_to quiz_index_path
    end
  end

  def create
    @quiz = Learn.find(params[:id])
    @quiz_make = @quiz.quizzes.build(quiz_params)
    if @quiz_make.save
      redirect_to quiz_index_path
    end
  end

  def show
    @quiz = Quiz.find_by(learn_id: params[:learn_id])
    @questions = Question.where(quiz_id: params[:quiz_id]).sample(5)
  end

  def create_user_answer
    grading = params[:answer]
    @correct = 0
    grading.each do |grading|
      find_question(grading[0])
      find_answer(grading[1])
      if @answer == @question.answer
        @correct+= 1
      end
    end
    puts params[:quiz_id]
    

    record = ((@correct.to_f/params[:answer].count)*100).round

    if check_for_quiz(current_user.id, params[:quiz_id])
      if @users_quiz.score < record
        @users_quiz.update(score: record)
        @users_quiz.attempts +=1
        @users_quiz.save
      else
        @users_quiz.attempts +=1
        @users_quiz.save
      end
    elsif @users_quiz.blank?
      @score = UserQuizResult.new(quiz_id: params[:quiz_id], user_id: current_user.id, score: record)
      if @score.save
        @success = "You successfully submitted your quiz!"
        update_attempt
      else
        @success = "Uh Oh! something went wrong"
      end
    end
  end

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
  end

  private 

  def quiz_params
    params.require(:quiz).permit(:title, :learn_id, 
      questions_attributes:[:id, :question, :answer, :quiz_id, :_destroy,
        answers_attributes:[:id ,:content, :question_id, :_destroy]]
      )
  end

  def question_params
    params.require(:question).permit(:question, :answer, :quiz_id)
  end

  def user_answer_params
    params.require(:user_quiz_answer).permit(quiz_id: params[:quiz_id][0], user_id: current_user.id, score: record)
  end

  def find_question(id)
    @question = Question.find(id)
  end

  def find_answer(id)
    @answer = Answer.find(id).content
  end

  def update_attempt
    @update = UserQuizResult.last
    @update.update(attempts: + 1)
  end

  def check_for_quiz(user,quiz)
    @users_quiz =  UserQuizResult.find_by(quiz_id: quiz.to_i, user_id: user)
  end
end
