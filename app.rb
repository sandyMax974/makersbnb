require 'sinatra'

class MakersBnB < Sinatra::Base

  enable :sessions

  get '/' do
    session[:listings] = ['space 1', 'space 2', 'space 3']
    erb :index
  end
  
  get '/confirmation' do
    p params
    erb :confirmation
  end

  post '/signup' do
    p params
    # store user information
    session[:username] = params[:username]
    redirect '/spaces'
  end

  get '/spaces' do
    @name = session[:username]
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