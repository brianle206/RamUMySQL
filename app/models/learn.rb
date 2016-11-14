class Learn < ActiveRecord::Base
	belongs_to :course
	has_many :lectures
	default_scope { order(id: :asc) }
	has_one :quiz, dependent: :destroy
end
