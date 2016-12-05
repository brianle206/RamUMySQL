class LearnsController < ApplicationController
  before_filter :find_section, only: [:show, :destroy]
  before_action :set_course, only: [:new, :create]

  def index
    @course = Course.all
  end

  def create
    @lecture = Lecture.all
    @module = Learn.all
    @learn = Learn.create(learn_params)
    if @learn.save
      redirect_to manage_courses_path
    end
  end

  def new 
    @learn = @courses.learns.build
  end
  
  def show
    @lecture = Lecture.where(learn_id: params[:id]).order('id ASC')
    @complete = Complete.new
  end
  
  def update
    @learn = Learn.find(params[:id])
    if @learn.update(learn_params)
      redirect_to manage_courses_path
    end
  end

  def edit
    @learn = Learn.find(params[:id])
  end

  def destroy
    @section.destroy
    redirect_to manage_courses_path
  end

  private

  def set_course
    @courses = Course.find_by(id: params[:course_id])
  end

  def learn_params
    params.require(:learn).permit(:title, :description, :img, :course_id)
  end

  def find_section
    @section = Learn.find(params[:id])
    @lectures = @section.lectures.page(params[:page]).per_page(1).order('id ASC')
  end
 
end
