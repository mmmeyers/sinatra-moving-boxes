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
    else
      @box = Box.create(:name => params[:name])
      if params[:name].empty?
        erb :new_box_error, :locals => {:name => "You didn't name the box."}
      else
      @box.user_id = current_user.id
      @box.save
      redirect '/boxes'
    end
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
      if params[:name].empty?
        erb :edit_box_error, :locals => {:name => "Please give this box a name."}
      else
      redirect '/boxes'
      end
    else
      redirect '/login'
    end
  end

  post '/boxes/:id/delete' do 
    if logged_in?
      @box = Box.find_by_id(params[:id])
      if @box.items.empty?
        @box.delete
        redirect '/boxes'
      else
        erb :delete_box_error
      end
    else
      redirect '/login'
    end
  end

end