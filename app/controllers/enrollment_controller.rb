class EnrollmentController < ApplicationController
  def add
  	@course = Enrollment.create(user_id: current_user.id, course_id: params[:course_id])
  	if @course.save
  		redirect_to :back
  	end
	end

	def update
	end
end
