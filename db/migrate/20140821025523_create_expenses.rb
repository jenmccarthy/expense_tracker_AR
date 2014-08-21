class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.column :description, :string
      t.column :price, :float
      
      t.timestamps
    end
  end
end
