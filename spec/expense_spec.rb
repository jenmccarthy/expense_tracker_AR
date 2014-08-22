require 'spec_helper'
require 'category'

describe Expense do
  
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  
  it 'converts the description to capital case' do
    expense = Expense.create({description: 'pizza', price: 4.99})
    expect(expense.description).to eq 'Pizza'
  end
  
  it 'belongs to a category' do
    category1 = Category.create({name: 'home', budget: 300})
    category2 = Category.create({name: 'work', budget: 500})
    expense1 = Expense.create({description: 'gasoline', price: 45.20, category_id: category1.id}) 
    expense2 = Expense.create ({description: 'groceries', price: 30.00, category_id: category1.id})
    expect(expense1.category).to eq category1
  end
  
end