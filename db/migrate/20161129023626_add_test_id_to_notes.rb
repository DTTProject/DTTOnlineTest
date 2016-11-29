class AddTestIdToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :test_id, :integer
  end
end
