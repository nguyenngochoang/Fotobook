class ChangeColumnNameInPhotos < ActiveRecord::Migration[5.2]
  def change
    rename_column  :photos, :picture_link, :attached_image
  end
end
