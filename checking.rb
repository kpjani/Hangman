require './hangman'
class Checking

  words = {}
  File.open('./new_file') do |file|
    file.each do |line|
      words[line.strip.upcase] = true
    end
  end

  hangman = Hangman.new
  response = hangman.start_game

  session_id = response['sessionId']
  number_of_words = response['data']['numberOfWordsToGuess']
  number_of_guesses = response['data']['numberOfGuessAllowedForEachWord']

  1.upto(number_of_words) do |i|
    word_response = hangman.next_word(session_id)

    wrong_guess = 0
    word_to_guess = word_response['word']
    word_length = word_to_guess.length
    available_chars = $AVAILABLE_CHARS.clone
    1.upto(26) do |char_pos|

      if(wrong_guess <=5 )
        no_options, character_to_guess = hangman.guess_char(char_pos, word_length)#(65 + rand(26)).chr
      else
        no_options, character_to_guess = hangman.smart_guess_char(word_to_guess, words, available_chars)
        available_chars.delete(character_to_guess)
      end


      word_response = hangman.guess_word(session_id, character_to_guess)

      word_to_guess = word_response['word']

      wrong_guess = word_response['wrongGuessCountOfCurrentWord']

      # move to next word if the number of guesses have exceeded or
      # if the word has been found out
      star_count = word_to_guess.count('*')
      if((wrong_guess == number_of_guesses) || (star_count == 0) || no_options == 0) ||  ( wrong_guess >= 8 &&  word_to_guess.count('*') >= 5 )#|| (wrong_guess > 6 && (no_options - star_count > 3)) ) #||  ))
        break
    end

      puts word_response
    end


    puts word_response
  end

  result = hangman.get_result(session_id)

  puts result

  if result['score'] > 500
    end_result = hangman.submit_result(session_id)
    puts end_result
  end



end



