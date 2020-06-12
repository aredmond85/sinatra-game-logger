class UserController < ApplicationController

    get '/signup' do 
        erb :'users/signup'
    end

    get '/login' do 
        erb :'users/login'
    end

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password]) 
            session[:user_id] = user.id
            redirect '/games'
        else
            erb :'sessions/login'
        end
    end


    post '/signup' do 
        @user = User.new(name: params[:name], password: params[:password], username: params[:username])
        if @user.save
            session[:user_id] = @user.id
            redirect "/games"
        else
            erb :'users/signup'
        end
    end

    delete '/logout' do 
        session.clear
        redirect '/login'
    end
end