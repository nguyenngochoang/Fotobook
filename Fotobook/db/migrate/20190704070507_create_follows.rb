class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.column "follower_id",  :integer, :null => false
      t.column "followee_id",  :integer, :null => false
      t.timestamps
    end
  end
end
