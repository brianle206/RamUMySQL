class LecturesController < ApplicationController
  before_action :set_learn, only: [:new]
  before_action :find_lecture, only: [:edit, :update, :show]
  before_action :authenticate_user!
  def index
    @learn = Learn.all
  end
  def create
    @lecture = Lecture.create(lecture_params)
    if @lecture.save
      redirect_to courses_path
    end
  end

  def update
    @lecture.update(lecture_params)
    redirect_to manage_courses_path
  end

  def destroy

  end

  def new 
    @lecture = @learn.lectures.build
  end

  def show
  end
  
  def edit 
  end

  private

  def set_learn
    @learn = Learn.find_by(id: params[:learn_id])
  end

  def find_lecture 
  	@lecture = Lecture.find(params[:id])
  end
  def lecture_params
    params.require(:lecture).permit(:title, :content, :learn_id)
  end
end
