class Badge < ActiveRecord::Base
	belongs_to :course
	# has_many :assertions
	validates_uniqueness_of :name

  def open_badge_as_json
    as_json(  only: [:name, :description, :image, :criteria, :issuer] )
  end
end
