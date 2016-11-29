class AddWeekIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :week_id, :integer
  end
end
