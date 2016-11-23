class Badge < ActiveRecord::Base
	belongs_to :course
	has_many :assertions
	validates_uniqueness_of :name
end
