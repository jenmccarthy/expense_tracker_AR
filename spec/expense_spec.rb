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
  
  describe 'self.time_period' do
    it 'will return all the expenses for a certain time period' do
      expense1 = Expense.create({description: 'pizza', price: 5.99, category_id: 1, created_at: '2014-08-20'})
      expense2 = Expense.create({description: 'gasoline', price: 40.00, category_id: 2, created_at: '2014-07-01'})
      expense3 = Expense.create({description: 'shampoo', price: 12.00, category_id: 3, created_at: '2014-08-13'})
      expect(Expense.time_period('2014-08-01', '2014-08-24')).to eq [expense1, expense3]
    end
  end
  
  it 'will total the monies spent on all expenses' do
    expense1 = Expense.create({description: 'pizza', price: 5.99, category_id: 1})
    expense2 = Expense.create({description: 'gasoline', price: 40.00, category_id: 2})
    expense3 = Expense.create({description: 'shampoo', price: 12.00, category_id: 3})
    expect(Expense.total).to eq 57.99
  end

  
end