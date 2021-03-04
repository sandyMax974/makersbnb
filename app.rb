require 'sinatra'
require './lib/listing'
require 'pg'
require_relative './lib/user'


class MakersBnB < Sinatra::Base

  enable :sessions

  get '/' do
    erb :user
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.authenticate(params[:email], params[:password])
    redirect '/spaces'
  end

  post '/signup' do
    @user = User.create(params[:username], params[:email], params[:password], params[:confirm_password])
    redirect '/spaces'
  end

  get '/spaces' do
    @name = User.current.name if User.current != nil# this can't retrive a loged in user at the moment
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

  post '/session/destroy' do
    User.logout
    redirect '/spaces'
  end

  get '/confirmation' do
    erb :confirmation
  end

  run! if app_file == $0
end
