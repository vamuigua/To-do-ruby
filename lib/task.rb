class Task
    #attribute reader
    attr_reader(:description, :list_id)
    
    #a global array to store all tasks created
#    @@all_tasks = []
    
    #To create an initialize method
    define_method(:initialize) do |attributes|
      @description = attributes.fetch(:description)
      @list_id = attributes.fetch(:list_id)
    end
    
    #class method to give all tasks
    define_singleton_method(:all) do
    #selecting all of the tasks from the tasks table in our database
      returned_tasks = DB.exec("SELECT * FROM tasks;")
    #empty array to store tasks
      tasks = []
    #loop through each of those tasks
      returned_tasks.each() do |task|
        #pull out the description
        description = task.fetch("description")
        #pull out the id
        list_id = task.fetch("list_id").to_i()
          # create a new Task object and push it into our tasks array
        tasks.push(Task.new({:description => description, :list_id => list_id}))
      end
      tasks
    end
    
    #instance method to save a new task
    define_method(:save) do
      DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});")
    end
    
    #class method to clear tasks from array
    define_singleton_method(:clear) do
      @@all_tasks = []
    end
    
    #making two objects with same description be treated as the same
    define_method(:==) do |another_task|
      self.description().==(another_task.description())
    end
end