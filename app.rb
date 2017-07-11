require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require('./lib/list')
require("pg")

DB = PG.connect({:dbname => "to_do"})

  get("/") do
    #an instance variable to hold our list of tasks returned from the class method Task.all()
    @tasks = Task.all()
    erb(:index)
  end

  get("/task/new") do
    erb(:new_task)
  end
  
 #Handling a post request because we are editing something
  post("/tasks") do
    #variable to hold the task description
    description = params.fetch("description")
    #creating a new task
    task = Task.new(description)
    #calling save method to save new task instance to the all_tasks array
    task.save()
    #Transition to success route/page
    erb(:success)
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