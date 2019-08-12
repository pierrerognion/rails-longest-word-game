require 'open-uri'
require 'json'
# frozen_string_literal: true

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score

    @attempt = params[:word]
    @grid = params[:letters].split(" ")
    
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    serialized_wagon_dic = open(url).read
      word = JSON.parse(serialized_wagon_dic)
      if word["found"] == false
        @result = { score: 0, message: "not an english word" }
      elsif @attempt.upcase.split(//).all? { |char| @grid.delete_at(@grid.index(char)) if @grid.include?(char) }
        @result = "well done"
      else
        @result = "not in the grid"
      end
    end
end