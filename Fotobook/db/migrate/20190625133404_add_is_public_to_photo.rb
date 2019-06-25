class AddIsPublicToPhoto < ActiveRecord::Migration[5.2]
  def change
      add_column :photos, :is_public, :boolean
  end
end
