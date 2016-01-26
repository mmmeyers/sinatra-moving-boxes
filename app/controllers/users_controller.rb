class UsersController < ApplicationController

  get '/users/:id' do 
    if !logged_in
      redirect '/boxes'
    end

    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'/boxes/boxes'
    else
      redirect '/boxes'
    end
  end

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
      @user.save
      session[:user_id] = @user.id 
    end
      redirect '/boxes'
  end

  get '/login' do 
    if logged_in?
      redirect '/boxes'
    else
    erb :'/users/login'
    end
  end

  post '/login' do 
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/boxes'
    else
      erb :error
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect '/login'
    end
  end

end