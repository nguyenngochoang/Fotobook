class AddActiveStatusToUsers < ActiveRecord::Migration[5.2]
  def up
      add_column :users, :active, :boolean, default: true
  end
  
  def down
     remove_column :users, :active
  end
end
