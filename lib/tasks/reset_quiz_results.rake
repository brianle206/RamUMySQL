namespace :db do
	desc "Deletes all quiz results from user_quiz_results table"
	task reset_quiz_results: :environment do
		puts "Deleting all quiz results"
		UserQuizResult.destroy_all
		puts "Finished"
	end
end