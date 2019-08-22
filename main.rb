require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'httparty'
require_relative 'db_config'
require_relative 'models/movie'

get '/' do
  erb(:index)
end

get '/about' do
  "hello"
  erb(:about)
end

get '/movie_list' do
  @counter = 0
  url = 'http://www.omdbapi.com/?s=' + params["s"] + '&apikey=2f6435d9'
  @search_result = HTTParty.get(url)
  
  if @search_result["totalResults"] > "1"
    erb :movie_list
  elsif @search_result["totalResults"] == "1"
      url = 'http://www.omdbapi.com/?t=' + params["s"] + '&apikey=2f6435d9'
      @result = HTTParty.get(url) 
      erb :movie
  end 
end

get '/movie-info' do
  if Movie.where(imdbid: "#{params["i"]}").any?
    @movie = Movie.where(imdbid: "#{params["i"]}")
    erb :movie_from_data
  else
    url = 'http://www.omdbapi.com/?i=' + params["i"] + '&apikey=2f6435d9'
    @result = HTTParty.get(url)
    movie = Movie.new
    movie.title = @result["Title"]
    movie.plot = @result["Plot"]
    movie.review_rating = @result["imdbRating"]
    movie.rated = @result["Rated"]
    movie.image_url = @result["Poster"]
    movie.year_released = @result["Year"]
    movie.director = @result["Director"]
    movie.genre = @result["Genre"]
    movie.imdbid = @result["imdbID"]
    movie.save
    erb(:movie)
  end
end
