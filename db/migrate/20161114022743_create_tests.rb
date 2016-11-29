class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.integer :user_id
      t.integer :status
      t.integer :start_time
      t.integer :end_time
      t.string :score

      t.timestamps
    end
  end
end
