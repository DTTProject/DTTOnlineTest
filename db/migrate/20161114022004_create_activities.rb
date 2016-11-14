class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :target_id
      t.integer :target_type

      t.timestamps
    end
  end
end
