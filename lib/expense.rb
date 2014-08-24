class Expense < ActiveRecord::Base
  
  validates :description, presence: true
  validates :price, presence: true
  
  before_save :capital_case
  
  belongs_to :category
  
  def self.time_period(start_date, end_date)
    time_expenses = []
    time_range = start_date...end_date
    results = Expense.where(created_at: time_range)
    results.each do |result|
      time_expenses << result
    end
    time_expenses
  end
  
  def self.total
    results = []
    Expense.all.each do |expense|
      results << expense.price
    end
    expense_total = results.inject{|sum, x| sum + x}
  end

private

  def capital_case
    self.description.capitalize!
  end
  
end