require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    input = ('A'..'Z').to_a
    @letters = []
    7.times { @letters << input.sample }
  end

  def score
    @valid = dict?(params[:userinput])
    @input = params[:userinput].upcase.split('')
    @board = params[:board].split(' ')
    @intersection = @input & @board
    @score = 0
    @message = (if @intersection.empty?
                  "Those letters weren't on the board..."
                elsif !@valid
                  "That isn't even a word!"
                else
                  @score = (@input.length * @input.length)
                  'Well done!'
                end)
    session[:score] = 0 unless session[:score]
    session[:score] += @score
    # raise
  end

  def dict?(input)
    JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{input}").read)['found'] # returns hash
  end
end
