class Article < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	has_many :lectures
	def self.search(search)
		where("title ILIKE ?","%#{search}%") || where("content ILIKE ?", "%#{search}%")
	end
end
