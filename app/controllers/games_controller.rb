require "open-uri"
require "json"

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.shuffle[0..9]
  end

  def score
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    json = JSON.parse(response)
    count = 0;
    params[:letters].split(' ').each do |letter|
      if params[:word].include?(letter)
        count += 1;
      end
    end

    if json["found"] == true && count == params[:word].length
      @score = "Score: #{json["length"].to_s}"
    else
      @score = "This is not a valid word"
    end
  end
end
