class UsersController < ApplicationController

  get '/signup' do 
    if logged_in?
      redirect '/boxes'
    else
      redirect '/users/signup'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
      binding.pry
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      @user.save
      redirect '/boxes'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/boxes'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/boxes"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect '/login'
  end
  


end