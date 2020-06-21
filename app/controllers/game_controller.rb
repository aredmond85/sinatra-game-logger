class GameController < ApplicationController
  
	get '/games' do
		authenticate
		if logged_in?
			@games = current_user.games
			erb :'/games/index'
		else
			redirect to '/login'
		end
	end
  
	get '/games/new' do
		authenticate
		if logged_in?
			erb :'/games/new'
		else
			redirect to '/login'
		end
  	end
  
	post '/games' do
		authenticate
		if logged_in?
			if params[:title] == "" || params[:console] == "" || params[:genre] == "" || params[:status] == ""
				@error = "Looks like something is wrong, try to fill out all the fields."
				redirect to "/games/new"
			else
				@game = Game.create(title: params[:title], console: params[:console], genre: params[:genre], status: params[:status])
				@game.user = current_user
				if @game.save
					redirect to "/games/#{@game.id}"
				else
					redirect '/games/new' 
				end
			end
		else
			redirect to '/login'
		end
  	end
  
	get '/games/show' do
		authenticate
		erb :'games/show'
  	end 
  
	get '/games/:id' do #loads show.erb to show game details
		authenticate
		@game = Game.find_by(id: params[:id])
		erb :'games/show'
  	end
  
	get '/games/:id/edit' do
		authenticate
		@game = Game.find_by(id: params[:id])
		erb :'games/edit'
  	end
  
	patch '/games/:id' do
		authenticate
		if params[:title] == "" || params[:console] == "" || params[:genre] == "" || params[:status] == ""
			@error = "Looks like something is wrong, try to fill out all the fields."
			erb :'/games/edit'
    	end
			@game = Game.find_by(id: params[:id])
			@game.title = params[:title]
			@game.console = params[:console]
			@game.genre = params[:genre]
			@game.status = params[:status]
			@game.save
			redirect "/games/#{@game.id}"
  	end
  
	delete '/games/:id' do
		authenticate
		@game = Game.find_by(id: params[:id])
		@game.delete
		redirect "/games"
	end
end
