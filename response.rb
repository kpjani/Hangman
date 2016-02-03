class Response
  def process_start_game(response)
    json_obj = JSON.parse(response)
  end

  def get_next_word(response)
    json_obj = JSON.parse(response)
    json_obj['data']
  end
end