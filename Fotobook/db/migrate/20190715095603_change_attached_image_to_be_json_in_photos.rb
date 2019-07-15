class ChangeAttachedImageToBeJsonInPhotos < ActiveRecord::Migration[5.2]
  def up
    change_column :photos, :attached_image, :json
  end
  
  def down
    change_column :photos, :attached_image, :text
  end
end
