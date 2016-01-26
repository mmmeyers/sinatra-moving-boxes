class BoxesController < ApplicationController

  get '/boxes' do 
    if logged_in?
      @boxes = Box.all 
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
      Box.create(params)
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

  get '/boxes/edit' do 
    if logged_in?
      @box = Box.find_by_id(params[:id])
      erb :'/boxes/edit'
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