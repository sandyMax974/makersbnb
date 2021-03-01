require 'sinatra'

class MakersBnB < Sinatra::Base

  enable :sessions

  get '/' do
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
    erb :spaces
  end

  run! if app_file == $0
end
