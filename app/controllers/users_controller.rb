class UsersController < ApplicationController

  get '/signup' do 
    if logged_in?
      redirect '/boxes'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id 
      redirect '/boxes'
    end
  end

  get '/login' do 
    @error_message = params[:error]
    if !session[:user_id]
      erb :'/users/login'
    else
      redirect '/boxes'
    end
  end

  post '/login' do 
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/boxes'
    else
      redirect '/signup'
    end
  end


end