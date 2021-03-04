require 'sinatra'
require './lib/listing'
require 'pg'
require_relative './lib/user'


class MakersBnB < Sinatra::Base

  enable :sessions

  get '/' do
    "Log in / Sign up (directs to /signup/new)"
  end

  get '/login' do
    "Login form"
    erb :login
  end

  get '/signup/new' do
    erb :user
  end

  post '/login' do
    # connection = PG.connect :dbname => "makersbnb_#{ENV['RACK_ENV']}"
    # result = connection.exec("SELECT * FROM users WHERE email = '#{params[:email]}'")
    # user = User.new(result[0]['id'], result[0]['username'], result[0]['email'], result[0]['password'], result[0]['password'])
    session[:user_id] = user.user_id.to_i
    redirec('/spaces')
  end

  post '/signup' do
    @user = User.create(params[:username], params[:email], params[:password], params[:confirm_password])
    redirect '/spaces'
  end

  get '/spaces' do
    @name = User.current.name # this can't retrive a loged in user at the moment
    @listings = Listing.all
    erb :spaces
  end

  get '/spaces/new' do
    erb :new
  end

  post '/spaces/new' do
    @user_id = User.current.user_id.first[:id]
    Listing.create(params[:title], params[:description], @user_id.to_i)
    redirect '/spaces'
  end

  get '/confirmation' do
    erb :confirmation
  end

  run! if app_file == $0
end
