class ChangeLikerIdToLikerName < ActiveRecord::Migration[5.2]
  def up
    rename_column :notifications, :liker_id, :liker_name
    change_column :notifications, :liker_name, :string 
  end
  
  def down
    rename_column :notifications, :liker_name, :liker_id
    change_column :notifications, :liker_id, :bigint
  end
end
