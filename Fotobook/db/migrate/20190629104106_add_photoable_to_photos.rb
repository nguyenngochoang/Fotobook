class AddPhotoableToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_reference :photos, :photoable, polymorphic: true
  end
end
