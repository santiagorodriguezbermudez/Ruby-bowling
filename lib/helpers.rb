module Helper
  def self.validate_input(data)
    # Check for input value
    return 'Error: The input file is empty' if data == ''

    # Check for incorrect format such as negative, decimals, outside range or incorrect format.
    data.split("\n").each_with_index.map do |el, index|
      turn = el.split(' ')
      error_message = "Error: Incorrect format on input file. Check your score from #{turn[0]} on line: #{index + 1}."
      return error_message if turn.length != 2 || !turn[1].match?(/^(0|[1-9]|10|F\d*)$/)
    end

    # Organize each player score accordingly
    organize_data = self.organize_data(data)

    # Check if number of turns per player is more than 10
    check_number_of_turn(organize_data)
  end

  def self.check_number_of_turn(data)
    data.each do |player_name, scores|
      return "Error: #{player_name} has less than 10 turns." if scores.size < 10

      turn10 = scores['turn: 10'.to_sym]
      turn11 = scores['turn: 11'.to_sym]
      if turn10[:turn_a] != 10 && turn11
        return "Error: #{player_name} has more turns than the 10 allowed" if turn11[:turn_b] || turn10[:turn_b] != 10
      end
    end
    true
  end

  def self.split_data(data)
    data.split("\n").map do |el|
      turn = el.split(' ')
      { player_name: turn[0], score: turn[1] }
    end
  end

  def self.organize_data(data)
    player_hash = get_players(data)

    split_data(data).each do |turn|
      player_name = turn[:player_name]
      score = turn[:score] == 'F' ? 'F' : turn[:score].to_i

      number_turn = player_hash[player_name].size
      current_turn = "turn: #{number_turn}".to_sym
      next_turn = "turn: #{number_turn + 1}".to_sym

      if number_turn.zero? || player_hash[player_name][current_turn][:turn_b]
        player_hash[player_name][next_turn] = { turn_a: score }
        player_hash[player_name][next_turn][:turn_b] = 0 if score == 10 && number_turn != 10
      else
        player_hash[player_name][current_turn][:turn_b] = score
      end
    end

    player_hash
  end

  def self.get_players(data)
    player_hash = {}

    split_data(data).each do |turn|
      player_name = turn[:player_name]
      player_hash[player_name] = {} unless player_hash[player_name]
    end

    player_hash
  end
end
