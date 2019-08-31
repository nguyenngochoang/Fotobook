class AddLikesToPhotosAlbums < ActiveRecord::Migration[5.2]
  def up
    add_column :photos, :likes, :integer, array: true, default: []
    add_column :albums, :likes, :integer, array: true, default: []
  end
  
  def down
    remove_column :photos, :likes, :integer, array: true, default: []
    remove_column :albums, :likes, :integer, array: true, default: []
  end
end
