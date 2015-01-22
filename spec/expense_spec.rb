require('spec_helper')

describe(Expense) do

  describe("#description") do
    it("returns a description of the expense") do
      expense_1 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expect(expense_1.description()).to(eq("lunch"))
    end
  end

  describe("#cost") do
    it("returns the cost of the expense") do
      expense_1 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expect(expense_1.cost()).to(eq("3.5"))
    end
  end

  describe("#date") do
    it("returns the date of the expense") do
      expense_1 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expect(expense_1.date()).to(eq("2011-01-08"))
    end
  end

  describe("#id") do
    it("returns the id of the expense") do
      expense_1 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expense_1.save()
      expect(expense_1.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("returns true if description and id are the same") do
      expense_1 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expense_2 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expect(expense_1).to(eq(expense_2))
    end
  end

  describe(".all") do
    it("returns no expenses at first") do
      expect(Expense.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("it returns an expense by its id number") do
      expense_1 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expense_1.save()
      expense_2 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expense_2.save()
      expect(Expense.find(expense_1.id())).to(eq(expense_1))
    end
  end

  describe('#categories') do
    it("returns array of categroies that belong to a specified expense") do
      test_category = Category.new({:category_name => "food", :id => nil})
      test_category.save()
      test_category2 = Category.new({:category_name => "restaurant", :id => nil})
      test_category2.save()
      expense_1 = Expense.new({:description => "lunch", :cost => "3.5", :date => "2011-01-08", :id => nil})
      expense_1.save()
      expense_1.add_category_to_expense(test_category)
      expense_1.add_category_to_expense(test_category2)
      expect(expense_1.categories()).to(eq([test_category, test_category2]))
    end
  end
end
