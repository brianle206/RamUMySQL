class Profile < ActiveRecord::Base
	belongs_to :users
	mount_uploader :avatar, AvatarUploader
end
