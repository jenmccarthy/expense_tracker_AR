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
  
  it 'will tell what percentage of all total expenses are being spent in a category' do
    category1 = Category.create({name: 'dining', budget: 100})
    category2 = Category.create({name: 'home', budget: 400})
    expense1 = Expense.create({description: 'pizza', price: 5.99, category_id: category1.id })
    expense2 = Expense.create({description: 'gasoline', price: 40.00, category_id: category2.id})
    expense3 = Expense.create({description: 'shampoo', price: 12.00, category_id: category2.id})
    expect(category2.category_percent).to eq 89
  end
  
  it 'will compare money spent in category to total budget set' do
    category1 = Category.create({name: 'dining', budget: 100})
    category2 = Category.create({name: 'home', budget: 400})
    expense1 = Expense.create({description: 'pizza', price: 5.99, category_id: category1.id })
    expense2 = Expense.create({description: 'gasoline', price: 40.00, category_id: category2.id})
    expense3 = Expense.create({description: 'shampoo', price: 12.00, category_id: category2.id})
    expect(category2.category_percent).to eq 89
  end
  
  it 'will compare total spent in a category to overall budget to return money left or overspent amount' do
    category1 = Category.create({name: 'home', budget: 400})
    expense1 = Expense.create({description: 'gasoline', price: 40.00, category_id: category1.id})
    expense2 = Expense.create({description: 'shampoo', price: 12.00, category_id: category1.id})
    expect(category1.in_budget).to eq 348
  end
  
end