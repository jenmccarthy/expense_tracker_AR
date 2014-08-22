class CreateCategoriesExpenses < ActiveRecord::Migration
  def change
    create_table :categories_expenses do |t|
      t.column :category_id, :integer
      t.column :expense_id, :integer
    end
  end
end
