class GameController < ApplicationController
  get '/games' do
    authenticate
    if logged_in?
      @games = current_user
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
      if params[:title] == "" || params[:console] == "" || params[:status] == ""
        redirect to "/games/new"
      else
        @game = Game.create(title: params[:title], console: params[:console], status: params[:status])
        @game.user = current_user
        if @game.save
          redirect to "/games"
          #redirect to "/games/#{@game.id}"
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

end
