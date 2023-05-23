require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a[rand(26)]
    end
  end

  def score
    @word = params[:word]
    @word_split = @word.split('')
    @answer = []
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @verification = URI.open(@url).read
    @valid = JSON.parse(@verification)
    @word_split.each do |letter|
      @answer << letter if params[:random].include?(letter)
    end
    if @answer.size != @word_split.size
      @result = "Sorry #{@word} can't be built with #{params[:random]}"
    elsif @valid['found']
      @result = "Congratulations #{@word} is a valid English word"
    else
      @result = "Sorry but #{@word} does not seem to be a valid English word ..."
    end
  end
end
