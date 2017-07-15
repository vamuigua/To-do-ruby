class Task
  #attribute reader
  attr_reader(:description,:id)

  #To create an initialize method
  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @id = attributes.fetch(:id)
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
      task_id = task.fetch("id").to_i()
      # create a new Task object and push it into our tasks array
      tasks.push(Task.new({:description => description, :id => task_id}))
    end
    tasks
  end

  #instance method to save a new task
  define_method(:save) do
    result = DB.exec("INSERT INTO tasks (description) VALUES ('#{@description}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  #class method to delete tasks
  define_method(:delete) do
    id=self.id.to_i()
    DB.exec("DELETE FROM tasks WHERE id = #{id};")
  end

  #making two objects with same description be treated as the same
  define_method(:==) do |another_task|
    self.description().==(another_task.description())
  end
end
