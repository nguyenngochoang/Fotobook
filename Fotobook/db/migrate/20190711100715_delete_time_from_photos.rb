class DeleteTimeFromPhotos < ActiveRecord::Migration[5.2]
  def change
      remove_column :photos, :time
  end
end
