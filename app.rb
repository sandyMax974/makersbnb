require 'sinatra'
require './lib/listing'
require 'pg'
require_relative './lib/user'


class MakersBnB < Sinatra::Base

  enable :sessions

  get '/' do
    erb :index
  end

  post '/signup' do
    @user = User.create( params[:username], params[:email], params[:password], params[:confirm_password])
    redirect '/spaces'
  end

  get '/spaces' do
    @name = User.current.name
    @listings = Listing.all
    erb :spaces
  end

  get '/spaces/new' do
    erb :new
  end

  post '/spaces/new' do
    Listing.create(params[:title], params[:description], 1 )
    redirect '/spaces'
  end

  post '/confirmation/:id' do
    Listing.book(params[:id], User.current.id)
    # @title = params[:title]
    erb :confirmation
  end

  run! if app_file == $0
end
