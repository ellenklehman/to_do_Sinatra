ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    Task.all().each() do |task|
      task.destroy()
    end
    List.all().each() do |list|
      list.destroy()
    end
  end
end
