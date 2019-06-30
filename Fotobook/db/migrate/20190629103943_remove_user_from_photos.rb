class RemoveUserFromPhotos < ActiveRecord::Migration[5.2]
  def change
    remove_reference :photos, :user, foreign_key: true
  end
end
