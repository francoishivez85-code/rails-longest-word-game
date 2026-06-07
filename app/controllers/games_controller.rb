require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].upcase

    # Vérifie si le mot peut être construit
    @included = @word.chars.all? { |letter| @letters.count(letter) >= @word.count(letter) }

    # Vérifie si c'est un mot anglais
    url = "https://dictionary.lewagon.com/#{@word.downcase}"
    response = URI.open(url).read
    json = JSON.parse(response)
    @english_word = json["found"]
  end
end
