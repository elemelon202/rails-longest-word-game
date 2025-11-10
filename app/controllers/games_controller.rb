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
    input = params[:word].chars
    in_grid = input.all? { |char| params[:letters].count(char) >= input.count(char) }

    if !api_send("https://dictionary.lewagon.com/#{input.join("")}")
    @message = "Mate....I legit checked and that is not an english word"
    elsif !in_grid
    @message = "You entered #{input.join("").upcase}, but you've gotta use only the available letters"
    else
    @score = "YOU SCORE: #{input.length * 100}"
    @message = "Well done"
    end
  end
end
