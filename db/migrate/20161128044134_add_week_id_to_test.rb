class AddWeekIdToTest < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :week_id, :integer
  end
end
