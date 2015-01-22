class Category
  attr_reader(:id, :category_name)

  define_method(:initialize) do |attributes|
    @category_name = attributes[:category_name]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO categories (category_name) VALUES ('#{@category_name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  define_singleton_method(:all) do
    returned_categories = DB.exec("SELECT * FROM categories;")
    categories = []
    returned_categories.each() do |category|
      category_name = category["category_name"]
      id = category["id"].to_i()
      categories.push(Category.new({:category_name => category_name, :id => id}))
    end
    categories
  end

  define_method(:==) do |another_category|
    self.category_name() == another_category.category_name() && self.id() == another_category.id()
  end

  define_singleton_method(:find) do |id|
    Category.all().each do |category|
      if(category.id() == id)
        @found_category = category
      end
    end
    @found_category
  end


  define_method(:add_expense_to_category) do |expense|
    existing_expense = DB.exec("SELECT * FROM expenses_categories WHERE categories_id = #{self.id()} AND expenses_id = #{expense.id()};")
    if ! existing_expense.first()
      DB.exec("INSERT INTO expenses_categories (expenses_id, categories_id) VALUES (#{expense.id()}, #{self.id()});")
    end
  end

  define_method(:expenses) do
    expenses = []
      returned_expenses = DB.exec("SELECT expenses.* FROM expenses JOIN expenses_categories ON (expenses.id = expenses_categories.expenses_id) JOIN categories ON (categories.id = expenses_categories.categories_id) WHERE categories.id = #{self.id()};")
      returned_expenses.each() do |expense_hash|
        description = expense_hash['description']
        cost = expense_hash['cost']
        date = expense_hash['date']
        id = expense_hash['id'].to_i()
        expenses.push(Expense.new({:description => description, :cost => cost, :date => date, :id => id}))
      end
    expenses
  end

end
