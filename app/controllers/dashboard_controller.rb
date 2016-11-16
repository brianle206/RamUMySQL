class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, :progress, :find_lessons

  def index
    
  end

  def settings
  end
  
  def show
    
  end

  def lessons
  end

  def edit
  end

  def update
  end

  def delete
  end

  def progress
    render 'progress'
  end

  private

  def find_user
    @user = User.find(current_user.id)
  end

  def find_lessons
    @lesson = Lecture.joins("JOIN learns ON learns.id = lectures.learn_id").order("id ASC")
  end
  
  def progress
    @article = Learn.all
    @progress = Complete.joins("INNER JOIN lectures ON lectures.id = completes.lecture_id INNER JOIN learns ON learns.id = lectures.learn_id AND completes.user_id = #{current_user.id} AND completes.lecture_id = lectures.id")
    @lessons = Lecture.joins("INNER JOIN learns ON lectures.learn_id = learns.id WHERE lectures.learn_id = learns.id").order('id ASC')
    @status = Complete.where(user_id: current_user.id)
  end

end
