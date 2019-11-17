require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = generate_array
  end

  def score
    word_array = params[:word].split(//)
    grid = params[:letters].split(//)
    word_array.each do |letter|
      if !grid.include?(letter)
        @message = "Sorry but #{params[:word].upcase} can't be bulit from #{grid}"
      elsif word_array.count(letter) > grid.count(letter)
        @message = "Sorry but #{params[:word].upcase} can't be bulit from #{grid}"
      else
        @message = check_word(params[:word])
      end
    end
  end

  def generate_array
    random_array = []

    10.times { random_array << ('a'..'z').to_a.sample }
    random_array
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    if user['found'] == true
      return "Congratulations! #{user['word'].upcase} ia a valid English word!"
    else
      return "Sorry, but #{user['word'].upcase} is not a valid English word..."
    end
  end
end

