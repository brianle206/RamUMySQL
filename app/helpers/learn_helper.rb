module LearnHelper
	def is_enrolled(course_id)
		@enroll = Enrollment.where(course_id: course_id, user_id: current_user.id)
		@already = Enrollment.where(course_id: course_id)
		@section = Course.find(course_id)
		@enrolled = false
		@enroll.each do |enroll|
			if enroll.course_id = course_id
				@enrolled = true
			end
		end
	rescue 
		nil

	end

	def is_legal
		course_id = Learn.find(params[:id])
		if Enrollment.where(user_id: current_user.id, course_id: course_id.course_id)
			puts "it Returned something"
			return @true
		else
			return @false
		end
	end
	def find_status(params)
	    @lecture = Lecture.find(params)
	    @status = Complete.where(user_id: current_user.id, lecture_id: @lecture.id)
  	end

 	def resource_name
    	:user
  	end

  	def resource
    	@resource ||= User.new
  	end

  	def devise_mapping
	    @devise_mapping ||= Devise.mappings[:user]
  	end
end
