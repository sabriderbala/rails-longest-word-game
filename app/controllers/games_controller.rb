require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    api = "https://wagon-dictionary.herokuapp.com/#{@word}"
    api_serialized = URI.open(api).read
    verification = JSON.parse(api_serialized)

    if check == false
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    elsif check && verification['found'] == false
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    elsif check && verification['found']
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end

  private

    ## Check if the word can be built out of the original grid
  def check
    @word.split("").all? { |letter| @word.count(letter) <= @letters.count(letter) }
  end
end
