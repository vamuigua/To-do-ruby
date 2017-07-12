require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require('./lib/list')
require("pg")

DB = PG.connect({:dbname => "to_do"})
# DB = PG.connect({:dbname => "to_do_test"})
  get("/") do
    #an instance variable to hold our list of tasks returned from the class method Task.all()
    @tasks = Task.all()
    erb(:index)
  end

  get("/task/new") do
    erb(:new_task)
  end
  
#route to new list form
  get("/lists/new") do
    erb(:list_form)
  end

#post requiest to get name of new list and route to success page
  post("/lists") do
    name = params.fetch("name")
    list = List.new({:name => name, :id => nil})
    list.save()
    erb(:success)
   end

#get request to show all the lists
   get('/lists') do
    @lists = List.all()
    erb(:lists)
  end

#get request to view specific list
  get("/lists/:id") do
    @list = List.find(params.fetch("id").to_i())
    erb(:list)
  end

#post request to post description and id for a new task created
  post("/tasks") do
    description = params.fetch("description")
    list_id = params.fetch("list_id").to_i()
    @list = List.find(list_id)
    @task = Task.new({:description => description, :list_id => list_id})
    @task.save()
    erb(:success)
  end