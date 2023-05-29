require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    @start_time = Time.now #COMO HAGO PARA QUE ESTA VARIABLE DE INSTANCIA ME LLEGUE CUANDO HACE SUBMIT?
  end

  def score
    @end_time = Time.now
    @try = params[:word].upcase.chars
    @letters = params[:letters].split(' ')
    @checker = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@try.join().downcase}").read)
    # @total_time = (@end_time - @start_time)
    if @try.all? { |char| @try.count(char) <= @letters.count(char) } # veo que cada letra se repita una sola vez
      if @checker['found']
        @message = 'well done'
      else
        
        @message = "It's not an english word"
      end
    else
      @message = "The word can't be created with those letters. You loose"
    end
  end
end


# attempt = gets.chomp


# La palabra no puede crearse a partir de la cuadrícula (grid) original
# La palabra es válida de acuerdo a la cuadrícula (grid) pero no es una palabra en ingles válida
# La palabra es válida de acuerdo a la cuadrícula (grid) y .es una palabra en inglés válida
