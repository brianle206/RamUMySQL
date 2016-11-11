class Learn < ActiveRecord::Base
	belongs_to :courses
	has_many :lectures
	has_many :quizzes, dependent: :destroy
end
