class GameController < ApplicationController
  get '/games' do
    authenticate
    @games = current_user
    erb :'/games/index'
  end

  get '/games/new' do
    authenticate
    erb :'/games/new'
  end

  post '/games/new' do 
    
  end

  get '/games/show' do
    
  end 
end