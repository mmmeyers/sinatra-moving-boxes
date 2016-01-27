class ItemsController < ApplicationController

  get '/items' do
    if logged_in?
      @item = current_user.items
      erb :'/items/items'
    else
      redirect '/login'
    end
  end

  get '/items/new' do 
    if logged_in?
      erb :'/items/new'
    else
      redirect '/login'
    end
  end

  post '/items' do 
    if !logged_in? || params[:item_name] == "" || params[:box_id] == nil
      erb :error, :locals => {:name => "Please enter an item and/or select a box."}
    else
      @item = Item.create(:item_name => params[:item_name])
      @item.user_id = current_user.id
      @item.box_id = params[:box_id]
      @item.save
      redirect '/items'
    end
  end

  get '/items/:id' do
    if logged_in?
      @items = Item.find_by_id(params[:id])
      erb :'/items/show_item'
    else
      redirect '/login'
    end
  end

  post '/items/:id' do 
    if logged_in?
      @item = Item.find_by_id(params[:id])
      @item.update(:item_name => params[:item_name])
      redirect '/items'
    else
      redirect '/login'
    end
  end

  post '/items/:id/delete' do 
    if logged_in?
      @item = Item.find_by_id(params[:id])
      @item.delete
      redirect '/items'
    else
      redirect '/login'
    end
  end


end