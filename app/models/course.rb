class Course < ActiveRecord::Base
	has_many :learns, dependent: :destroy
end
