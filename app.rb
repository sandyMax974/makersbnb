require 'sinatra'
require 'uri'
require 'sinatra/flash'
require_relative './lib/user'
class MakersBnB < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    session[:listings] = ['space 1', 'space 2', 'space 3']
    erb :index
  end

  get '/confirmation' do
    erb :confirmation
  end

  post '/signup' do
    if User.validate_email?(params[:email]) && User.validate_password?(params[:password], params[:confirm_password])
      @user = User.create( params[:username], params[:email], params[:password], params[:confirm_password])
      redirect '/spaces'
    else
      if User.validate_password?(params[:password], params[:confirm_password])
        flash[:notice] = "You must submit a valid email"
      else
        flash[:notice] = "Passwords must match"
      end
      redirect '/'
    end
  end

  get '/spaces' do
    @username = User.current.name
    @listings = session[:listings]
    erb :spaces
  end

  get '/spaces/new' do
    erb :new
  end

  post '/spaces/new' do
    session[:listings] << params[:House_number]
    #store listing information
    redirect '/spaces'
  end

  run! if app_file == $0
end


=begin

1 - turn space into variables

2 - new controller method delete



=end
