require 'spec_helper'

describe Category do
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :budget }
  
  it 'has many expenses' do
    category1 = Category.create({name: 'home', budget: 300})
    category2 = Category.create({name: 'work', budget: 500})
    expense1 = Expense.create({description: 'gasoline', price: 45.20, category_id: category1.id}) 
    expense2 = Expense.create ({description: 'groceries', price: 30.00, category_id: category1.id})
    expect(category1.expenses).to eq [expense1, expense2]
  end
  
end