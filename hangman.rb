require 'rest_client'
require './request'
require './constants'
require './response'

class Hangman
  def start_game
    req_obj = Request.new
    res_obj = Response.new

    req = req_obj.start_game('ketanjani21@gmail.com')

    response = RestClient.post($url_path, req.to_json)
    json_response = res_obj.process_start_game(response)

    json_response
  end

  def submit_result(session_id)
    req_obj = Request.new
    res_obj = Response.new

    req = req_obj.submit_result(session_id)
    response = RestClient.post($url_path, req.to_json)
    json_response = res_obj.get_next_word(response)
  end

  def next_word(session_id)
    req_obj = Request.new
    res_obj = Response.new

    req = req_obj.get_next_word(session_id)
    response = RestClient.post($url_path, req.to_json)
    json_response = res_obj.get_next_word(response)
  end

  def guess_word(session_id, character)
    req_obj = Request.new
    res_obj = Response.new

    req = req_obj.guess_word(session_id, character)
    response = RestClient.post($url_path, req.to_json)
    json_response = res_obj.get_next_word(response)

  end

  def get_result(session_id)
    req_obj = Request.new
    res_obj = Response.new

    req = req_obj.get_result(session_id)
    response = RestClient.post($url_path, req.to_json)
    json_response = res_obj.get_next_word(response)
  end

  def guess_char(position, length)
    [1, $char_array[position-1][length-1]]
  end

  def smart_guess_char(word_to_guess, words, available_chars)
    reg_ex = word_to_guess.gsub('*','.{1}')
    possible_options = words.keys.grep (Regexp.new(reg_ex))
    possible_chars_h = {}
    qualified_options = 0
    possible_options.each do |possible_option|
      if(possible_option.length == word_to_guess.length)
        qualified_options = qualified_options + 1
        new_chars = (possible_option.split('') - word_to_guess.split('')).uniq
        new_chars.each do |new_char|
          if(possible_chars_h[new_char])
            possible_chars_h[new_char] = possible_chars_h[new_char]+1
          else
            possible_chars_h[new_char] = 1
          end
        end
      end
    end

    max = 0
    max_char = ''


    possible_chars_h.each do |key, value|
      if (!available_chars.include?(key))
        possible_chars_h.delete(key)
      elsif value > max
        max = value
        max_char = key
      end
    end

    [possible_chars_h.length, max_char]
  end

end