require('rspec')
  require('task')

  describe(Task) do
      before() do
      Task.clear()
    end
      
    describe("#description") do
      it("lets you give it a description") do
        test_task = Task.new("scrub the zebra")
        expect(test_task.description()).to(eq("scrub the zebra"))
      end
    end
      
    describe(".all") do
        it("is empty at first") do
            expect(Task.all()).to(eq([]))
        end
    end
      
    #save method that adds a task to the array
    describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new("wash the lion")
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

    #clear method to remove tasks from the array
    describe(".clear") do
    it("empties out all of the saved tasks") do
      Task.new("wash the lion").save()
      Task.clear()
      expect(Task.all()).to(eq([]))
    end
  end
end