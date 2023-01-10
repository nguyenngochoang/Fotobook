class AddStateToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :state, :boolean, default: false
  end
end
