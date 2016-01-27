class BoxesController < ApplicationController

  get '/boxes' do 
    if logged_in?
      @boxes = current_user.boxes
      erb :'/boxes/boxes'
    else
      redirect '/login'
    end
  end

  get '/boxes/new' do 
    if logged_in?
      erb :'/boxes/new'
    else
      redirect '/login'
    end
  end

  post '/boxes' do 
    if !logged_in?
      erb :error
    else
      @box = Box.create(:name => params[:name])
      @box.user_id = current_user.id
      @box.save
      redirect '/boxes'
    end
  end

  get '/boxes/:id' do 
    if logged_in? 
      @boxes = Box.find_by_id(params[:id])
      erb :'/boxes/show_box'
    else
      redirect '/login'
    end
  end

  post '/boxes/:id' do 
    if logged_in?
      @box = Box.find_by_id(params[:id])
      @box.update(:name => params[:name])
      redirect '/boxes'
    else
      redirect '/login'
    end
  end

  post '/boxes/:id/delete' do 
    if logged_in?
      @box = Box.find_by_id(params[:id])
      @box.delete
      redirect '/boxes'
    else
      redirect '/login'
    end
  end

end