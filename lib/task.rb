class Task
    #a global array to store all tasks created
    @@all_tasks = []
    
    #To create an initialize method
    define_method(:initialize) do |description|
      @description = description
    end
    
    #instance method to give description of a task
    define_method(:description) do
      @description
    end
    
    #class method to give all tasks
    define_singleton_method(:all) do
      @@all_tasks
    end
    
    #instance method to save a new task
    define_method(:save) do
      @@all_tasks.push(self)
    end
    
    #class method to clear tasks from array
    define_singleton_method(:clear) do
      @@all_tasks = []
    end
end