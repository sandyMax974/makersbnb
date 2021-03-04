# frozen_string_literal: true

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
    if User.current == nil
      redirect '/login'
    else
      redirect '/spaces'
    end
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
    @user_id = User.current.user_id
    Listing.create(params[:title], params[:description], @user_id.to_i)
    redirect '/spaces'
  end


  post '/confirmation/:id' do
    @title = Listing.book(params[:id], User.current.user_id)
    erb :confirmation
    end

  post '/session/destroy' do
    User.logout
    redirect '/spaces'
  end

  run! if app_file == $PROGRAM_NAME
end
