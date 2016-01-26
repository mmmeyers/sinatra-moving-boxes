class BoxesController < ApplicationController

  get '/boxes' do
    @user = User.find_by(session[:user_id])
    if @user.id == session[:user_id]
      @boxes = Box.all
      erb :'/boxes/boxes'
    else
      redirect '/'
    end
  end

  get '/boxes/new' do
    if logged_in?
      erb :'/boxes/new'
    else
      redirect '/login'
    end
  end

  post '/boxes/new' do
    if params[:name] != nil
      @box = Box.create(:name => params[:name])
      @box.user = User.find(session[:user_id])
      @box.save
      redirect '/boxes'
    else
      redirect '/login'
    end
  end

  get '/boxes/:id' do
    binding.pry
    redirect_if_not_logged_in
    @box = Box.find(params[:id])
    erb :'/boxes/show_box'
  end


end