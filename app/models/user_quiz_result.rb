class UserQuizResult < ActiveRecord::Base
	belongs_to :users
	belongs_to :quiz
end
