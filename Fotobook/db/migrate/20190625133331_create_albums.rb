class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.date :time
      t.integer :like
      t.boolean :is_public

      t.timestamps
    end
  end
end
