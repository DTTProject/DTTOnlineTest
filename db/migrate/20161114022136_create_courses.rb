class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.integer :question_numbers
      t.integer :duration
      t.string :image

      t.timestamps
    end
  end
end
