class AddMaskAsReadToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :mask_as_read, :boolean
  end
end
