require 'spec_helper'

describe Expense do
  
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  
  it 'converts the description to capital case' do
    expense = Expense.create({description: 'pizza', price: 4.99})
    expect(expense.description).to eq 'Pizza'
  end
  
end