class AddDescriptionToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :description, :text
  end
end
