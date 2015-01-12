require('rspec')
require('task')

describe(Task) do
  before() do
    Task.clear()
  end

  describe('#initialize') do
    it("is initialized with a description") do
      test_task = Task.new("scrub the zebra")
      expect(test_task).to(be_an_instance_of(Task))
    end
  end

  it("lets you read the description out") do
    test_task = Task.new("scrub the zebra")
    expect(test_task.description()).to(eq("scrub the zebra"))
  end

  describe('.all') do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new("wash the lion")
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe(".clear") do
    it("empties out all of the saved tasks") do
      Task.new("wash the lion").save()
      Task.clear()
      expect(Task.all()).to(eq([]))
    end
  end
end
