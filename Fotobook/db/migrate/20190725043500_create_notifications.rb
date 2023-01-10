class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :action
      t.string :target_type
      t.references :user, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
