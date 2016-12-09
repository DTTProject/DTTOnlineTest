class AddTargetIdToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :target_id, :integer
  end
end
