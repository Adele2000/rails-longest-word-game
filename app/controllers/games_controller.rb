require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @answer = params[:word].upcase
    @included = included?(@answer, @letters)
    @english = english?(@answer)
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english?(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    response = URI.open(url)
    json = JSON.parse(response.read)
    json['found']
  end
end
