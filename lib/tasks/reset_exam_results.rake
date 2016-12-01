namespace :db do
	desc "Deletes all exam results from user_exam_results table"
	task reset_exam_results: :environment do
		puts "Deleting all quiz results"
		UserExamResult.destroy_all
		puts "Finished"
	end
end