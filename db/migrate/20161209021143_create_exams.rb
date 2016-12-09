class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.integer :user_id
      t.integer :test_id
      t.integer :status
      t.integer :start_time
      t.integer :end_time
      t.string :score
      t.integer :type

      t.timestamps
    end
  end
end
