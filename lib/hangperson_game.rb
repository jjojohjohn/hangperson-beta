class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if (letter == nil || !letter.match(/^[a-zA-Z]$/))
      raise ArgumentError, "invalid guess"
    end
    if ((@guesses.include? letter) || (@wrong_guesses.include? letter))
      return false
    end
    if (@word.include? letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    return true
    end
  end

  def word_with_guesses
    current_status = ''
    @word.split("").each do |letter|
      if(@guesses.include? letter)
        current_status += letter
      else
        current_status += '-'
      end
    end
    return current_status
  end

  def check_win_or_lose
    win = true
    @word.split("").each do |letter|
      if (!@guesses.include? letter)
        win = false
      end
    end
    if(win)
      return :win
    elsif (@wrong_guesses.size == 7)
      return :lose
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
