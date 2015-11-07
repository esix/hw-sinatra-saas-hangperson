class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(ch)
    raise ArgumentError, "" unless ch.is_a? String
    raise ArgumentError, "" if ch.length == 0
    raise ArgumentError, "" unless ch =~ /[[:alpha:]]/i
    
    ch.downcase!
    is_used =  @guesses.include?(ch) || @wrong_guesses.include?(ch)
    
    if @word.include? ch
      @guesses += ch unless @guesses.include? ch
    else
      @wrong_guesses += ch unless @wrong_guesses.include? ch
    end
  
    return !is_used
  end
  
  def word_with_guesses
    @word.chars.map { |ch| if @guesses.include?(ch) then ch else '-' end }.join
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif @word.chars.select { |ch| !@guesses.include?(ch)  }.length == 0
      :win
    else
      :play
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
