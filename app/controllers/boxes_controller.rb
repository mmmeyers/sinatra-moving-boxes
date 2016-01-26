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

  get '/boxes/:slug' do
  @box = Box.find_by_slug(params[:slug])

    if is_logged_in?
      erb :'/boxes/show_box'
    else
      redirect '/login'
    end
  end
    

end