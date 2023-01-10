class AddLikerIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :liker_id, :bigint
  end
end
