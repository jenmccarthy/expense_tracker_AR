class Category < ActiveRecord::Base
  
  validates :name, presence: true
  validates :budget, presence: true
  
end