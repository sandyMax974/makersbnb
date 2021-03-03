require 'sinatra'
require './lib/listing'
require 'pg'

class MakersBnB < Sinatra::Base

  enable :sessions

  get '/' do
    # session[:listings] = ['House 1', 'House 2', 'House 3']
    erb :index
  end

  post '/signup' do
    p params
    # store user information
    session[:username] = params[:username]
    redirect '/spaces'
  end

  get '/spaces' do
    @name = session[:username]
    connection = PG.connect :dbname => "makersbnb_#{ENV['RACK_ENV']}"
    @result = connection.exec("SELECT * FROM listings;")
    @listings = @result.map { |listing| listing['title']}
    # @listings = session[:listings]
    erb :spaces
  end

  get '/spaces/new' do
    erb :new
  end

  post '/spaces/new' do
    p params
    # session[:listings] << params[:House_number]
    p @name = session[:username]
    Listing.create(params[:title], params[:description], 1 )
    # store listing information
    redirect '/spaces'
  end

  get '/confirmation' do
    erb :confirmation
  end

  run! if app_file == $0
end


=begin

1 - turn space into variables

2 - new controller method delete



=end
