require 'sinatra'

class MakersBnB < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/confirmation' do
    erb :confirmation
  end

  run! if app_file == $0
end
