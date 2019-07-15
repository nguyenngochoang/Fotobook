class ChangeIsPublicToSharingModeInAlbums < ActiveRecord::Migration[5.2]
  def up
    rename_column :albums, :is_public, :sharing_mode
  end
  
  def down
    rename_column :albums, :sharing_mode, :is_public  
  end
end
