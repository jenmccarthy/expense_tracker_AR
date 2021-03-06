require 'bundler/setup'
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

I18n.enforce_available_locales = false

ActiveRecord::Base.establish_connection(YAML::load(File.open('db/config.yml'))["test"])


RSpec.configure do |config|
  config.after(:each) do
    Expense.all.each { |expense| expense.destroy }
    Category.all.each { |category| category.destroy }
  end
end
