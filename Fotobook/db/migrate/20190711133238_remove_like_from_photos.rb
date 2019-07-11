class RemoveLikeFromPhotos < ActiveRecord::Migration[5.2]
  def change
      remove_column :photos, :like
  end
end
