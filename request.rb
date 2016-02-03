class Request
  def start_game(email)
    req = {
        'playerId' => email,
        'action' => 'startGame'
    }
  end

  def get_next_word(session_id)
    req = {
        'sessionId' => session_id,
        'action' => 'nextWord'
    }
  end

  def submit_result(session_id)
    req = {
        'sessionId' => session_id,
        'action' => 'submitResult'
    }
  end

  def guess_word(session_id, character)
    req = {
        'sessionId' => session_id,
        'action' => 'guessWord',
        'guess' => character
    }
  end

  def get_result(session_id)
    req = {
        'sessionId' => session_id,
        'action' => 'getResult',
    }
  end

end