namespace :db do
	desc "Deletes all assertions from assertions table"
	task reset_assertions: :environment do
		puts "Deleting all assertions"
		Assertion.destroy_all
		puts "Finished"
	end
end
