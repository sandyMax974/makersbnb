require 'sinatra'
require './lib/listing'
require 'pg'
require_relative './lib/user'


class MakersBnB < Sinatra::Base

  enable :sessions

  get '/' do
    erb :index
  end

  get '/confirmation' do
    erb :confirmation
  end

  post '/signup' do
    @user = User.create( params[:username], params[:email], params[:password], params[:confirm_password])
    redirect '/spaces'
  end

  get '/spaces' do
    connection = PG.connect :dbname => "makersbnb_#{ENV['RACK_ENV']}"
    @result = connection.exec("SELECT * FROM listings;")
    @listings = @result.map { |listing| listing['title']}
    @name = User.current.name

    erb :spaces
  end

  get '/spaces/new' do
    erb :new
  end

  post '/spaces/new' do
    Listing.create(params[:title], params[:description], 1 )
    redirect '/spaces'
  end

  get '/confirmation' do
    erb :confirmation
  end

  run! if app_file == $0
end


