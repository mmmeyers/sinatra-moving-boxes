class ItemsController < ApplicationController

  get '/items' do
    if logged_in?
      @item = Item.all 
      erb :'/items/items'
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
      @item.user_id = current_user.id
      @item.save
      redirect '/items'
    end
  end


end