class Quiz < ActiveRecord::Base
	belongs_to :learn
	has_many :answers, through: :questions
	has_many :questions, :dependent => :destroy
	accepts_nested_attributes_for :questions, :allow_destroy => true
end
