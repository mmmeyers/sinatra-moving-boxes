class ItemsController < ApplicationController

  get '/items' do
    if logged_in?

      @item = current_user.items.all
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
    if !logged_in?
      erb :error
    else
      @item = Item.create(:item_name => params[:item_name])
      if params[:item_name] == "" || params[:box_id] == nil
        erb :item_error, :locals => {:name => "You didn't add an item's name or select a box for it."}
      else
        @item.user_id = current_user.id
        @item.box_id = params[:box_id]
        @item.save
        redirect '/items'
      end
    end
  end

  get '/items/:id' do
    if logged_in?
      @item = Item.find_by_id(params[:id])
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