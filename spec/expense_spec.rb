require 'spec_helper'

require 'bundler/setup'
Bundler.require(:default, :test)

describe Expense do
  
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  
end