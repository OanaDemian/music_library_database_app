# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end
   get '/' do
    return erb(:index)
   end

   get '/about' do
    return erb(:about)
   end
   
   get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)
   end

   get '/albums/:id' do
    id = params[:id]
    repo = AlbumRepository.new
    album = repo.find(id) 
    @title,@release_year,@artist_id = album.title,album.release_year,album.artist_id
    artist_repo = ArtistRepository.new
    @artist_name = artist_repo.find(album.artist_id).name
    return erb(:album)
    end

   post '/albums' do
      title = params[:title]
      release_year = params[:release_year]
      artist_id = params[:artist_id]
      repo = AlbumRepository.new
      new_album = Album.new
      new_album.title = title
      new_album.release_year = release_year
      new_album.artist_id = artist_id
      repo.create(new_album)
      return ""
    end

    get '/artists' do
      repo = ArtistRepository.new
      @artists = repo.all
      return erb(:artists)
    end

     get '/artists/:id' do
       id = params[:id]
       repo = ArtistRepository.new
       artist = repo.find(id)
       @name = artist.name
       @genre = artist.genre
       return erb(:artist)
    end
     
     post '/artists' do
      name = params[:name]
      genre = params[:genre]
      repo = ArtistRepository.new
      new_artist = Artist.new
      new_artist.name = name
      new_artist.genre = genre
      repo.create(new_artist)
      return ""
     end
end