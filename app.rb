require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/category")
require("./lib/expense")
require("pg")

DB = PG.connect({:dbname => "expense_organizer"})

get("/") do
  erb(:index)
end

get("/categories/:id") do
  @id = params["id"].to_i()

  erb(:categories)
end

get("/expenses/:id") do
  @id = params["id"].to_i()
  erb(:expenses)
end

post("/categories") do
  category_name = params['category_name'].strip()
  if category_name !=""
    new_category = Category.new({:category_name => category_name})
    new_category.save()
  end
  erb(:index)
end

post("/expenses") do
  description = params['description'].strip()
  cost = params['cost'].strip()
  date = params['date'].strip()
  if description != "" && cost != "" && date != ""
    new_expense = Expense.new({:description => description, :cost => cost, :date => date})
    new_expense.save()
  end
  erb(:index)
end

post("/categories/:id") do
  id = params['id'].to_i()
  associated_expense = Expense.find(id)

  erb(:categories)
end
#
# post("/lines/:line_id") do
#   line_id = params.fetch('line_id').to_i()
#   station_id = params.fetch('station_id').to_i()
#   line = Line.find(line_id)
#   station = Station.find(station_id)
#   station.add_line(line)
#   url = "/admin/lines/" + line_id.to_s()
#   redirect(url)
# end

post("/expenses/:id") do

  erb(:expenses)
end
