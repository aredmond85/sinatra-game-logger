class UserController < ApplicationController

    get '/signup' do 
      erb :"users/signup"
    end

    post '/signup' do
        if params[:username] == "" || params[:first_name] == "" || params[:last_name] == "" || params[:password] == ""
            redirect to '/signup'
          else
            @user = User.new(:username => params[:username], :first_name => params[:first_name], :last_name => params[:last_name], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/games'
          end
    end

    get '/login' do
        if !logged_in?
          erb :'users/login'
        else
          redirect to '/games'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/games"
        else
          redirect to '/login'
        end
      end

    post '/logout' do
        if logged_in?
          session.destroy
          redirect to '/login'
        else
          redirect to '/'
        end
    end
end