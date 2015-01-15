require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("./lib/list")
require("pg")


DB = PG.connect({:dbname => "to_do"})

get("/") do
  @lists = List.all()
  erb(:index)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new(name)
  list.save()
  @lists = List.all()
  erb(:index)
end

get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  task = Task.new(description, list_id)
  task.save()
  @list = List.find(list_id)
  erb(:list)
end
