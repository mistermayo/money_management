class Expense
  attr_reader(:description, :cost, :date, :id)

  define_method(:initialize) do |attributes|
    @description = attributes[:description]
    @cost = attributes[:cost]
    @date = attributes[:date]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_expenses = DB.exec("SELECT * FROM expenses;")
    expenses = []
    returned_expenses.each() do |expense|
      description = expense["description"]
      cost = expense["cost"]
      date = expense["date"]
      id = expense["id"].to_i()
      expenses.push(Expense.new({:description => description, :cost => cost, :date => date, :id => id}))
    end
    expenses
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (description, cost, date) VALUES ('#{@description}', #{@cost}, '#{@date}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  define_method(:==) do |another_expense|
    self.description() == another_expense.description() && self.id() == another_expense.id() && self.date() == another_expense.date() && self.cost() == another_expense.cost()
  end

  define_singleton_method(:find) do |id|
    Expense.all().each do |expense|
      if(expense.id() == id)
        @found_expense = expense
      end
    end
    @found_expense
  end

  define_method(:add_category_to_expense) do |category|
    existing_category = DB.exec("SELECT * FROM expenses_categories WHERE expenses_id = #{self.id()} AND categories_id = #{category.id()};")
    if ! existing_category.first()
      DB.exec("INSERT INTO expenses_categories (expenses_id, categories_id) VALUES (#{self.id()}, #{category.id()});")
    end
  end

  define_method(:categories) do
    categories = []
      returned_categories = DB.exec("SELECT categories.* FROM categories JOIN expenses_categories ON (categories.id = expenses_categories.categories_id) JOIN expenses ON (expenses.id = expenses_categories.expenses_id) WHERE expenses.id = #{self.id()};")
      returned_categories.each() do |category_hash|
        category_name = category_hash['category_name']
        id = category_hash['id'].to_i()
        categories.push(Category.new({:category_name => category_name, :id => id}))
      end
    categories
  end

end
