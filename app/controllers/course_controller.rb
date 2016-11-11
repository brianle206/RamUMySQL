class CourseController < ApplicationController
  def update
  	@course = Course.find(params[:id])
  	if @course.update(course_params)
  		redirect_to course_path(@course)
  	end
  end

  def create
  	@course = Course.create(course_params)
  	if @course.save
  		render 'index'
  	end
  end

  def edit
  	@course = Course.find(params[:id])
  end

  def destroy
  end

  def index
  	@course = Course.all
  end

  def show
  	@course = Course.find(params[:id])
  end
  def new 
  	@course = Course.new
  end

  private

  def course_params
  	params.require(:course).permit(:title, :description )
  end
end
