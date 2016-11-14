class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :status
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.text :suggestion
      t.integer :complexity

      t.timestamps
    end
  end
end
