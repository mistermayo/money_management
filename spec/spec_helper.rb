require('rspec')
require ('pg')
require('expense')
require('category')
require('pry')

DB = PG.connect({:dbname => 'expense_organizer_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM  categories *;")
    DB.exec("DELETE FROM  expenses_categories *;")
  end
end
