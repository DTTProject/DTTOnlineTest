class ChangeTestIdNameInResults < ActiveRecord::Migration[5.0]
  def change
    rename_column :results, :test_id, :exam_id
  end
end
