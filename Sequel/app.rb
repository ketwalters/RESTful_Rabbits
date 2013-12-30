require 'bundler'
Bundler.require
require './lib/rabbit'

class App < Sinatra::Application

get '/rabbits' do 
	@rabbits = Rabbit.all
	haml :index
end

get '/rabbits/new' do
	@rabbit = Rabbit.new
	haml :new
end

post '/rabbits' do
	@rabbit = Rabbit.new(params[:rabbit])
	if @rabbit.save
		status 201
		redirect '/rabbits' + @rabbit.id.to_s
	else
		status 400
		haml :new
	end
end

get '/rabbits/edit/:id' do
	@rabbit = Rabbit.find(id: params[:id])
	haml :edit
end

put 'rabbits/:id' do
	@rabbit = Rabbit.find(id: params[:id])
	if @rabbit.update(params[:rabbit])
		status 201
		redirect '/rabbits' + params[:id]
	else
		status 400
		haml :edit
	end
end

get '/rabbits/delete/:id' do
  @rabbit = Rabbit.find(id: params[:id])
  haml :delete
end

delete '/rabbits/:id' do
  Rabbit.find(id: params[:id]).destroy
  redirect '/rabbits'  
end

get '/rabbits/:id' do
  @rabbit = Rabbit.find(id: params[:id])
  haml :show
end


end
