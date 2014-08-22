class Expense < ActiveRecord::Base
  
  validates :description, presence: true
  validates :price, presence: true
  
  before_save :capital_case
  
  belongs_to :category

private

  def capital_case
    self.description.capitalize!
  end
  
end