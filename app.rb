require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/wordguesser_game.rb'

class WordGuesserApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || WordGuesserGame.new('')
  end
  
  after do
    session[:game] = @game
  end
  
  # These two routes are good examples of Sinatra syntax
  # to help you with the rest of the assignment
  get '/' do
   redirect '/new'
   #"<!DOCTYPE html><html><head></head><body><h1>Hello World</h1></body></html>"
  end
  
  get '/new' do
    erb :new
  end
  
  post '/new' do
    "<!DOCTYPE html><html><head></head><body><h1>Hello World</h1></body></html>"
  end
    
  
    
  post '/create' do
    # NOTE: don't change next line - it's needed by autograder!
    word = params[:word] || WordGuesserGame.get_random_word
    # NOTE: don't change previous line - it's needed by autograder!

    @game = WordGuesserGame.new(word)
    redirect '/show'
  end
  
  # Use existing methods in WordGuesserGame to process a guess.
  # If a guess is repeated, set flash[:message] to "You have already used that letter."
  # If a guess is invalid, set flash[:message] to "Invalid guess."
  post '/guess' do
    letter = params[:guess].to_s[0]
    @game.guess(letter)
    state = @game.check_win_or_lose
    if state == :win
      redirect '/win'
    elsif state == :lose
      redirect '/lose'
    end
    ### YOUR CODE HERE ###
    redirect '/show'
  end
  
  # Everytime a guess is made, we should eventually end up at this route.
  # Use existing methods in WordGuesserGame to check if player has
  # won, lost, or neither, and take the appropriate action.
  # Notice that the show.erb template expects to use the instance variables
  # wrong_guesses and word_with_guesses from @game.
  get '/show' do
    
    erb :show # You may change/remove this line
  end
  
  get '/win' do
    ### YOUR CODE HERE ###
    erb :win # You may change/remove this line
  end
  
  get '/lose' do
    ### YOUR CODE HERE ###
    erb :lose # You may change/remove this line
  end
  
end
