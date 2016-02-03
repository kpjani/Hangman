require './constants'
class Test
  word_to_guess = 'CONNECTION*ESS'
  reg_ex = word_to_guess.gsub('*','.{1}')
  puts word_to_guess

  words = {}
  File.open("./new_file") do |file|
    file.each do |line|
      words[line.strip.upcase] = true
    end
  end

  available_chars = $AVAILABLE_CHARS.clone
  # available_chars.delete('H')
  # puts $AVAILABLE_CHARS
  # puts available_chars

  possible_options = words.keys.grep (Regexp.new(reg_ex))

  possible_chars_h = {}
  qualified_options = 0
  possible_options.each do |possible_option|
    if(possible_option.length == word_to_guess.length)
      puts possible_option
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
  qualified_options
  min = 500
  min_char = ''
  puts possible_chars_h.keys
  possible_chars_h.each do |key, value|
    if (qualified_options != 1 && value == qualified_options) || !available_chars.include?(key)
      possible_chars_h.delete(key)
    elsif value < min
      min = value
      min_char = key
    end
  end


  puts min_char

end