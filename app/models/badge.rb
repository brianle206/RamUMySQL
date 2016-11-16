class Badge < ActiveRecord::Base
	# belongs_to :course
	validates_uniqueness_of :name
end
