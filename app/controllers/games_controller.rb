require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def api_send(url)
    read = URI.open(url).read
    checked = JSON.parse(read)
    checked["found"]
  end
  def new
    alphabet = ("a".."z").to_a
    @letters = alphabet.sample(10).map {|l| l.upcase}
  end

def score
  word = params[:word].downcase
  letters = params[:letters].downcase.chars.tally
  input_chars = word.chars

  in_grid = input_chars.all? { |char| input_chars.count(char) <= letters[char].to_i }

  if !api_send("https://dictionary.lewagon.com/#{word}")
    @message = "Mate....I legit checked and that is not an English word"
  elsif !in_grid
    @message = "You entered #{word.upcase}, but you've gotta use only the available letters"
  else
    @score = "You scored: #{input_chars.length * 100}"
    @message = "Well done"
  end
end
end
