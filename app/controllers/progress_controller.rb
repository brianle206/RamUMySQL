class ProgressController < ApplicationController
  def add
  	@progress = Complete.create(user_id: params[:user_id], lecture_id: params[:lecture_id], status: true, learn_id: params[:learn_id])
  	if @progress.save
  		redirect_to :back
  	end
  end
end
