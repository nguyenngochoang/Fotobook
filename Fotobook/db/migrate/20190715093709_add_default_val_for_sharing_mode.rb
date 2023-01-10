class AddDefaultValForSharingMode < ActiveRecord::Migration[5.2]
  def up
      change_column_default :photos, :sharing_mode, true
      change_column_default :albums, :sharing_mode, true
  end
  
  def down
    change_column_default :photos, :sharing_mode, nil 
    change_column_default :albums, :sharing_mode, nil
  end
end
