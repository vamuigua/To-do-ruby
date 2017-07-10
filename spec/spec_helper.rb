#require the same files and gems 
require("rspec")
  require("pg")
  require("list")
  require("task")

#create a database connection
  DB = PG.connect({:dbname => "to_do_test"})

#set up RSpec to clean the database between test runs
  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM lists *;")
      DB.exec("DELETE FROM tasks *;")
    end
  end