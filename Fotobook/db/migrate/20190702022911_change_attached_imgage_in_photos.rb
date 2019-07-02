class ChangeAttachedImgageInPhotos < ActiveRecord::Migration[5.2]
  def change
      change_column :photos, :attached_image, :text
  end
end
