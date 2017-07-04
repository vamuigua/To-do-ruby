class Task
    #a global array to store all tasks created
    @@all_tasks = []
    
    #To create an initialize method
    define_method(:initialize) do |description|
      @description = description
    end
    
    #description method
    define_method(:description) do
      @description
    end
    
    #To create a class method to check if array is empty
    define_singleton_method(:all) do
      @@all_tasks
    end
    
    #method to save task
    define_method(:save) do
      @@all_tasks.push(self)
    end
    
    #method to clear tasks from array
    define_singleton_method(:clear) do
      @@all_tasks = []
    end
end