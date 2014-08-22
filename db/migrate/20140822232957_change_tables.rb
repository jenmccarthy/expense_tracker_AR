class ChangeTables < ActiveRecord::Migration
    drop_table :categories_expenses
  def change
    add_column :expenses, :category_id, :integer
  end
end
