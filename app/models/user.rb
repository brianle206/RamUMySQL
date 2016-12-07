class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :profiles, :dependent => :destroy
  has_many :articles
  has_many :lectures,  :through => :articles
  has_many :completes
  has_many :user_quiz_results
end
