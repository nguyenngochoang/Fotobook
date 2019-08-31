class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.json :attached_image
      t.string :title
      t.text :description
      t.boolean :sharing_mode
      t.references :user, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
