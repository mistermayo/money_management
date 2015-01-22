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
  erb(:)
end

post("/expenses") do
  description = param['description'].strip()
  cost = param['cost'].strip()
  date = param['date'].strip()
  end
  erb(:)
end
