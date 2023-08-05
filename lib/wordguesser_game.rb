class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @displayed =''

  end

  attr_accessor :word , :guesses , :wrong_guesses

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

  
  def word_with_guesses
    for i in 0..(@word.length-1) do
      if guesses.include?(word[i])
        @displayed += word[i]
      else 
        @displayed += "-"
      end
    end
    return @displayed 
  end

  def check_win_or_lose 
    word_with_guesses
    if @displayed == @word  and @wrong_guesses.length < 7
      return :win
    elsif @displayed != @word and @wrong_guesses.length < 7
      return :play
    else
      return :lose
    end
  end

  def guess(guess_char)
    raise ArgumentError if guess_char.nil? or guess_char.empty? or guess_char =~ /\W/ 
    guess_char = guess_char.downcase 
    if @guesses.include?(guess_char) or @wrong_guesses.include?(guess_char) 
      return false
    end
    @guesses += guess_char if @word.include?(guess_char)
    @wrong_guesses += guess_char if !@word.include?(guess_char)
    
    return true
  end

end
