class LearnController < ApplicationController
  before_filter :find_section, only: [:show, :destroy]
  before_action :find_lecture, only: [:show, :add_lecture]
  before_action :this_lecture, only: [:lecture_show, :lecture_edit, :lecture_update]
  before_action :find_status, only: [:lecture_show]
  include LearnHelper
  
  def index
    @course = Course.all
  end

  def create
    @lecture = Lecture.all
    @module = Learn.all
    @learn = Learn.create(learn_params)
    if @learn.save
      render 'index'
    end
  end

  def new 
    @learn = Learn.new
  end
  
  def show
    @lecture = Lecture.where(learn_id: params[:id]).order('id ASC')
  end
  
  def update
    @learn = Learn.find(params[:id])
    if @learn.update(learn_params)
      redirect_to lecture_index_path
    end
  end

  def edit
    @learn = Learn.find(params[:id])
  end

  def destroy
    @section.destroy
  end

  def add_lecture
    @lecture = Lecture.new
  end

  def create_lecture
    @section = Learn.find(params[:id])
    @lecture = @section.lectures.build(lecture_params)
    if @lecture.save
      redirect_to lecture_index_path
    end
  end

  def lecture_show
    @lecture = Lecture.where(id: params[:lid])
    render 'lecture_show'
  end

  def lecture_edit
    
  end

  def lecture_update
    @lecture.update(lecture_params)
    redirect_to @lecture
  end

  def lecture_destroy
    @lecture = Lecture.find(params[:lid])
    if @lecture.present? 
      @lecture.destroy
    end
    redirect_to root_path
  end

  private

  def find_lecture
    @lecture = Lecture.where(learn_id: params[:id])
  end

  def this_lecture
    @lecture = Lecture.find(params[:lid])
  end

  def lecture_params
    params.require(:lecture).permit(:title, :content, :learn_id)
  end

  def learn_params
    params.require(:learn).permit(:title, :description, :img, :course_id)
  end

  def find_section
    @section = Learn.find(params[:id])
    @lectures = @section.lectures.page(params[:page]).per_page(1).order('id ASC')
  end

  def find_status
    @lecture = Lecture.find(params[:lid])
    @status = Complete.where(user_id: current_user.id, lecture_id: @lecture.id)
  end
  
end
