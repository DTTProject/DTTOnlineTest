class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.integer :question_id
      t.integer :test_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
