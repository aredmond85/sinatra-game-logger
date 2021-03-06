class ApplicationController < Sinatra::Base
 
    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions unless test?
      set :session_secret, "secret"
    end
  
    get '/' do
      erb :index
    end

    self.helpers do 

      def current_user
          User.find_by(id: session[:user_id])
      end

      def logged_in?
          !!current_user
      end

      def authenticate 
          redirect '/login' if !logged_in?
      end 
    end

end