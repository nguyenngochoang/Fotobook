class ChangeIsPublicToSharingModeInAlbums < ActiveRecord::Migration[5.2]
  def change
      rename_column :albums, :is_public, :sharing_mode
  end
end
