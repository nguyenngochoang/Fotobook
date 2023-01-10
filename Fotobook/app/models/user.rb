class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader

  paginates_per 40

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable, :trackable
  has_many :photos, as: :photoable, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :notifications

  has_many :albums_photos, through: :albums, source: :photos

  #table contains current_user.id and all users.id followed current_user
  #foreign_key is used for specify :followee_id will be used to find follower_followee_follows of user instead of using follower_followee_follows.id by default
  has_many :follower_followee_follows, foreign_key: :followee_id, class_name: "Follow",dependent: :destroy
  #table contains all info about each users from table1 except current_user
  has_many :followers, through: :follower_followee_follows,  source: :follower,dependent: :destroy

  # in this table, current_user is the follower
  #table contains all followees of current_user, using current_user.id as foreign_key
  has_many :followee_follower_follows, foreign_key: :follower_id, class_name: "Follow",dependent: :destroy
  #table contains all info about current_user followees
  has_many :followees, through: :followee_follower_follows, source: :followee,dependent: :destroy

  has_many :followees_photos, -> {order "created_at desc"; where(sharing_mode: true)}, through: :followees, source: :photos
  has_many :followees_albums, -> {order "created_at desc"; where(sharing_mode: true)}, through: :followees, source: :albums

  validates :first_name, :last_name, presence: true, length: { maximum: 25, too_long: "25 characters are maximum allowed!" }
  validates :email, length: { maximum: 255, too_long: "255 characters are maximum allowed!" }
  validates :avatar, file_size: { less_than: 5.megabytes }

  def active_for_authentication?
    super and self.active?
  end

  def inactive_message
    "Sorry, this account has been deactivated"
  end

end
