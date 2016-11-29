class CreateWeeks < ActiveRecord::Migration[5.0]
  def change
    create_table :weeks do |t|
      t.references :course, foreign_key: true
      t.string :content
      t.text :description

      t.timestamps
    end
  end
end
