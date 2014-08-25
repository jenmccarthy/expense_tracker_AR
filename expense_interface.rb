require 'bundler/setup'
Bundler.require(:default)
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('db/config.yml'))["development"])

def category_menu
  list_all_categories
  puts "Press [a] to enter the name of a new category:"
  puts "Press [e] to go to the expense menu"
  puts "Press [x] to wipe out your expense organizer"
  menu_choice = gets.chomp
  if menu_choice == 'a'
    create_category
  elsif menu_choice == 'e'
    expense_menu
  elsif menu_choice == 'x'
    wipeout
  else
    puts "Please choose a valid option"
    category_menu
  end
end

def wipeout
  Expense.all.each { |expense| expense.destroy }
  Category.all.each { |category| category.destroy }
  puts "Your organizer has been wiped clean!"
end

def list_all_categories
  if Category.all.empty?
    puts "Please add a category"
    create_category
  else
    Category.all.each_with_index do |category, index|
      name = category.name
      puts "[#{index + 1}] #{name}\n\n"
    end
  end
end

def create_category
  puts "Please enter a new category type:"
  input_category = gets.chomp
  puts "Please enter a monthly budget for this category:"
  budget = gets.chomp
  Category.create({name: input_category, budget: budget})
  puts "Your category has been added!"
  puts "\n\n"
  category_menu
end

def list_all_expenses
  if Expense.all.empty?
    puts "Choose an option"
  else
    Expense.all.each do |expense|
      description = expense.description
      price = expense.price
      created_at = expense.created_at
      created_at = created_at.strftime('%Y/%m/%d')
      puts "#{created_at} -- #{description} -- #{price}\n\n"
    end
  end
end

def expense_menu
    list_all_expenses
    puts"\n\n"
    puts "Press [a] to add an expense"
    puts "Press [c] to view a category's spending"
    puts "Press [x] to exit"
    menu_choice = gets.chomp
    if menu_choice == 'a'
      add_expense
    elsif menu_choice == 'c'
      check_category
    elsif menu_choice == 'x'
      exit
      puts "Goodbye!"
    else
      puts "That is not a valid input, please choose again"
    end
end

def add_expense
  puts "Please enter the description of your purchase:"
  input_description = gets.chomp
  puts "Please enter the price:"
  input_price = gets.chomp.to_f
  puts "What category is this expense:"
  input_category = gets.chomp
  current_category = Category.where(name: input_category).first
  Expense.create({description: input_description, price: input_price, category_id: current_category.id})
  puts "\nYour expense has been added\n\n"
  expense_menu
end

def check_category
  list_all_categories
  puts "Which category would you like to view?"
  category_choice = gets.chomp.to_i - 1
  chosen_category = Category.all[category_choice]
  budget = chosen_category.budget
  percentage = chosen_category.category_percent
  leftovers = chosen_category.in_budget
  puts "Here is the total amount you have alloted this category: $#{budget}"
  puts "Here is your remaining dollars for this category: $#{leftovers}"
  puts "Here is the percentage of your total spent toward this particular category: #{percentage}%"
  puts "\n\n"
  puts "Would you like to return to the expense menu? Y/N"
  choice = gets.chomp.downcase
  if choice == 'y'
    expense_menu
  else
    puts "Thank you for using the expense organizer!  You will exit the program now."
  end
end
  


category_menu
