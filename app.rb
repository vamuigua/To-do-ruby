require("sinatra")
  require("sinatra/reloader")
  also_reload("lib/**/*.rb")
  require("./lib/task")

  get("/") do
    #a new instance variable to hold our list of tasks returned from the class method Task.all()
    @tasks = Task.all()
    erb(:index)
  end

 #Handling a post request bcoz we are editing something
  post("/tasks") do
    description = params.fetch("description")
    task = Task.new(description)
      #calling save method to save new task instance to the @@all_tasks array
    task.save()
    erb(:success)
  end