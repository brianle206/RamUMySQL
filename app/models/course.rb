class Course < ActiveRecord::Base
	has_many :learns, dependent: :destroy
	# has_one :badge
end
