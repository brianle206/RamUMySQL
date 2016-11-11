class LecturesController < ApplicationController
	before_action :find_lecture, only: [:destroy]
  before_action :find_lec_edit, except: [:edit, :index]
  before_action :authenticate_user!
  def index
    @learn = Learn.all
  end
  def create
  end

  def update
    @lecture.update(lecture_params)
    redirect_to '/learn'
  end

  def destroy
  	@lecture.destroy

    redirect_to '/learn'
  end

  private

  def find_lec_edit
    @lecture = Lecture.find(params[:id])
  end
  def find_lecture 
  	@lecture = Lecture.find(params[:id])
  end
  def lecture_params
    params.require(:lecture).permit(:title, :content, :learn_id)
  end
end
