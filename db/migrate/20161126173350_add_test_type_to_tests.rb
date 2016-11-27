class AddTestTypeToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :test_type, :integer
  end
end
