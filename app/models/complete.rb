class Complete < ActiveRecord::Base
	belongs_to :users, :dependent => :destroy
	belongs_to :lectures
end
