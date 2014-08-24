class Category < ActiveRecord::Base
  
  validates :name, presence: true
  validates :budget, presence: true
  
  has_many :expenses
  
  def category_percent
    results = []
    category_expenses = Expense.where(category_id: self.id)
    category_expenses.each do |expense|
      results << expense.price 
    end
    category_total = results.inject{|sum, x| sum + x}
    decimal = category_total / Expense.total
    category_percent = decimal * 100
    category_percent.floor
  end
  
  def in_budget
    results = []
    category_expenses = Expense.where(category_id: self.id)
    category_expenses.each do |expense|
      results << expense.price 
    end
    category_total = results.inject{|sum, x| sum + x}
    leftovers = self.budget - category_total
  end
  
  
end