class ChangeAssociations < ActiveRecord::Migration
  def change
    drop_table :categories_expenses
    add_column :expenses, :category_id, :integer
  end
end
