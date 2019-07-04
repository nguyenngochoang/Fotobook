class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :photos, as: :photoable
  has_many :albums
  
  #table contains current_user.id and all users.id followed current_user
  has_many :follower_followees, foreign_key: :followee_id, class_name: "Follow" 
  #table contains all info about each users from table1 except current_user
  has_many :followers, through: :follower_followees, source: :follower

  #this table current_user is the follower
  #table contains all followees of current_user, using current_user.id as foreign_key
  has_many :followee_followers, foreign_key: :follower_id, class_name: "Follow"
  #table contains all info about current_user followees
  has_many :followees, through: :followee_followers, source: :followee
  
  validates :first_name, :last_name, presence: true, length: { maximum: 25, too_long: "25 characters are maximum allowed!" }
  validates :email, length: { maximum: 255, too_long: "255 characters are maximum allowed!" }
end
