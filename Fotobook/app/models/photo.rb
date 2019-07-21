class Photo < ApplicationRecord

  mount_uploader :attached_image, ImageUploader

  paginates_per 40

  belongs_to :photoable, polymorphic: true, optional: true
  validates :title, presence: true, length: { maximum: 140, too_long: "140 characters are maximum allowed!" }
  validates :description, length: {maximum: 300, too_long: "300 characters are maximum allowed!" }
  validates :photoable_type, inclusion: {in: %w"User Album", message: "%{value} is invalid."}
  validates :attached_image, file_size: { less_than: 5.megabytes }

end
