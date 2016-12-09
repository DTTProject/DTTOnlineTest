class ChangeTypeNameInExams < ActiveRecord::Migration[5.0]
  def change
    rename_column :exams, :type, :test_type
  end
end
