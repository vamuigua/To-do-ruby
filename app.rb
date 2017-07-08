require("sinatra")
  require("sinatra/reloader")
  also_reload("lib/**/*.rb")
  require("./lib/task")

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