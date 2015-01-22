require('spec_helper')

describe(Category) do
  describe("#category_name") do
    it("returns the name of a category") do
      test_category = Category.new({:category_name => "food", :id => nil})
      expect(test_category.category_name()).to(eq("food"))
    end
  end

  describe("#id") do
    it("returns the id of a category") do
      test_category = Category.new({:category_name => "food", :id => nil})
      test_category.save()
      expect(test_category.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".all") do
    it("returns empty at first") do
      expect(Category.all()).to(eq([]))
    end
  end

  describe(":==") do
    it("returns true if category_name and id are the same") do
      test_category = Category.new({:category_name => "food", :id => nil})
      test_category2 = Category.new({:category_name => "food", :id => nil})
      expect(test_category).to(eq(test_category2))
    end
  end

  describe(".find") do
    it("returns a category by its id number") do
      test_category = Category.new({:category_name => "food", :id => nil})
      test_category.save()
      test_category2 = Category.new({:category_name => "food", :id => nil})
      test_category2.save()
      expect(Category.find(test_category.id())).to(eq(test_category))
    end
  end

  describe('#expenses') do
    it("returns array of expenses that go into a specified category") do
      test_category = Category.new({:category_name => "food", :id => nil})
      test_category.save()
      expense_1 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expense_1.save()
      expense_2 = Expense.new({:description => "dinner", :cost => "5", :date => "2011-01-27", :id => nil})
      expense_2.save()
      test_category.add_expense_to_category(expense_1)
      test_category.add_expense_to_category(expense_2)
      expect(test_category.expenses()).to(eq([expense_1, expense_2]))
    end
  end
end
