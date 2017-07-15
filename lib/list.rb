class List
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      list_id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => list_id}))
    end
    lists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    #first() is used to get the ID of the list and fetch() to select the ID
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_list|
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end

  define_singleton_method(:find) do |id|
    found_list = nil
    List.all().each() do |list|
      if list.id().==(id)
        found_list = list
      end
    end
    found_list
  end

  #method to add a task to the database
  define_method(:add_task) do |task_id|
    @list_id = self.id.to_i()
    DB.exec("UPDATE tasks SET list_id = #{@list_id} WHERE id=#{task_id};")
  end

  define_method(:tasks) do
    list_tasks = []
    tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id()};")
    tasks.each() do |task|
      description = task.fetch("description")
      task_id = task.fetch("id").to_i()
      list_tasks.push(Task.new({:description => description, :id=> task_id}))
    end
    list_tasks
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE lists SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM lists WHERE id = #{self.id()};")
    DB.exec("DELETE FROM tasks WHERE list_id = #{self.id()};")
  end
end
