#all files required from spec_helper.rb
require("spec_helper")

#To clear things out before each spec run
describe(Task) do

  #Test method for giving all tasks when empty
  describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  #Test to give description
  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :id => nil})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  #save method that adds a new task
  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :id => nil})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  #method to allow you to read the list ID out
  describe("#id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :id => nil})
      expect(test_task.id()).to(eq(nil))
    end
  end

  #to make two objects with the same properties are treated the same in our specs
  describe("#==") do
    it("is the same task if it has the same description and list ID") do
      tasknil = Task.new({:description => "learn SQL", :id => nil})
      task2 = Task.new({:description => "learn SQL", :id => nil})
      expect(tasknil).to(eq(task2))
    end
  end

  #spec to delete a specific client
  describe("#delete") do
    it("Lets you delete tasks in the database") do
      test_task = Task.new({:description => "learn SQL", :id => nil})
      test_task.save()
      test_task.delete()
      expect(Task.all()).to(eq([]))
    end
  end
end
