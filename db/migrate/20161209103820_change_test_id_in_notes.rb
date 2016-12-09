class ChangeTestIdInNotes < ActiveRecord::Migration[5.0]
  def change
    rename_column :notes, :test_id, :exam_id
  end
end
