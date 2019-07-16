class AddLikesToPhotos < ActiveRecord::Migration[5.2]
  def change
      add_column :photos, :like, :integer, default: 0
  end
end
