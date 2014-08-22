class DropTable < ActiveRecord::Migration
  def change
    drop_table :categories_expenses
  end
  add_column :expenses, :category_id, :integer
end
