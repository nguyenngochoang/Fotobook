class AddDefaultValueForSharingMode < ActiveRecord::Migration[5.2]
  def change
      def up
        change_column :photos, :sharing_mode, :boolean, default: true
       
      end
      
      def down
        change_column :photos, :sharing_mode, :boolean, default: nil
      end
      
  end
end
