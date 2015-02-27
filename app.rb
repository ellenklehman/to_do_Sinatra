require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  @lists = List.all
  @list = List.new
  erb :index
end

post '/lists' do
  @lists = List.all
  name = params["name"]
  @list = List.new(name: name, id: nil)
  if @list.save
    redirect "/lists/#{@list.id}"
  else
    erb :index
  end
end

get '/lists/:id' do
  @list = List.find(params["id"].to_i)
  erb :list
end

post '/tasks' do
  description = params["description"]
  list_id = params["list_id"].to_i
  task = Task.create(description: description, list_id: list_id)
  @list = List.find(list_id)
  erb :list
end

get '/lists/:id/edit' do
  @list = List.find(params["id"].to_i)
  erb :list_edit
end

patch '/lists/:id' do
  name = params["name"]
  @list = List.find(params["id"].to_i)
  if @list.update(name: name)
    redirect "/"
  else
    erb :list
  end
end

delete '/lists/:id' do
  @lists = List.all
  @list = List.find(params["id"].to_i)
  if @list.destroy
    redirect "/"
  else
    erb :index
  end
end
