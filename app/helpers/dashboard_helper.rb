module DashboardHelper

	def courses
    	@courses = Enrollment.where(user_id: current_user.id)
    rescue
    	nil
	end

	def find_learn(id)
		@learn = Learn.where(id: id)
	    @number_of_lectures = find_lecture(id).count
	    @complete = find_complete(id).count
	    @percentage = ((@complete.to_f/@number_of_lectures) * 100)
	end

	def find_lecture(id)
		@lecture = Lecture.where(learn_id: id).order('id ASC')
	end

	def find_complete(id)
		@complete = Complete.where(learn_id: id, user_id: current_user.id)
	end

	def find_users_quiz_score
		@user_scores = UserQuizResult.where(user_id: current_user.id)
	end

	def find_quiz_title(quiz)
		@quiz_title = Quiz.find(quiz).title
	end

	def complete(user,lecture,learn)
		@done = Complete.find_by(user_id: user, lecture_id: lecture, learn_id: learn)
	end
end
