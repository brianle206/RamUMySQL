class ProgressController < ApplicationController
  def add
    puts params[:complete]
   

  	@progress = Complete.create(user_id: params[:complete][:user_id], lecture_id: params[:complete][:lecture_id], status: params[:complete][:status], learn_id: params[:complete][:learn_id])
  	if @progress.save
      puts "It Saved"
      flash[:notice] = "Congrats on completing that lecture!!"
  	end
  end
  private 

  def complete_params
  	params.require(:completes).permit(:user_id, :lecture_id, :learn_id, :status => true)
  end
end
