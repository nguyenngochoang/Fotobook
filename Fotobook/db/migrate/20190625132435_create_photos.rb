class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :picture_link
      t.string :status_title
      t.text :status
      t.date :time
      t.integer :like
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
