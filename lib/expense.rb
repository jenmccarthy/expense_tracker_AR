class Expense < ActiveRecord::Base
  
  validates :description, presence: true
  validates :price, presence: true
  
  before_save :capital_case

private

  def capital_case
    self.description.capitalize!
  end
  
end