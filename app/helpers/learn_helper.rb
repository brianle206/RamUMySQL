module LearnHelper
	def is_enrolled(course_id)
		@enroll = Enrollment.where(course_id: course_id, user_id: current_user.id)
		@enrolled = false
		@enroll.each do |enroll|
			if enroll.course_id = course_id
				@enrolled = true
			end
		end
	rescue 
		nil

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
