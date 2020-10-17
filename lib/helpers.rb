module Helper
  def self.validate_input(data)
    
    # Check for input value
    return 'Error: The input file is empty' if data == ''

    #Check for incorrect format such as negative, decimals, outside range or incorrect format.
    array_of_turns = data.split("\n").each_with_index.map do |el, index|
      turn = el.split(' ')
      error_message = "Error: Incorrect format on input file. Check your score from #{turn[0]} on line: #{index + 1} of your file"
      return error_message if turn.length != 2 || !turn[1].match?(/^(0|[1-9]|10|F\d*)$/)
    end

    # Organize each player score accordingly
    organize_data = self.organize_data(data)

    # Check if number of turns per player is less than 10
    organize_data.each do |player_name, scores|
      if scores.length > 11
        return "Error: #{player_name} has #{scores.length-11} turns more than the 10 allowed"
      elsif scores.length == 11
        turn_10 = scores[-2]["turn: 10".to_sym]
        turn_11 = scores[-1]["turn: 11".to_sym]
        
        if turn_10[:turn_a] != 10
          if turn_11[:turn_b] || turn_10[:turn_b] != 10
            return "Error: #{player_name} has 1 more turn than the 10 allowed"
          end
        end
      end
    end

    true
  end

  def self.organize_data(data)
    turns_data = data.split("\n").map do |el|
      turn = el.split(' ')
      {
        player_name: turn[0],
        score: turn[1]
      }
    end

    player_hash = Hash.new

    turns_data.each do |turn|

      player_name = turn[:player_name]
      score = turn[:score].to_i

      if player_hash[player_name]

        if player_hash[player_name][-1]["turn: #{player_hash[player_name].length}".to_sym][:turn_b]
          if score == 10 && player_hash[player_name].length != 10
            player_hash[player_name] << {
              "turn: #{player_hash[player_name].length + 1}": {
                  turn_a: score,
                  turn_b: 0,
                }
            }
          else
            player_hash[player_name] << {
              "turn: #{player_hash[player_name].length + 1}": {
                  turn_a: score
                }
            }
          end
        else
          player_hash[player_name][-1]["turn: #{player_hash[player_name].length}".to_sym][:turn_b] = score
        end

      else

        if score == 10
          player_hash[player_name] = [
            {
              "turn: 1": {
                turn_a: score,
                turn_b: 0,
              }
            }
          ]
        else
          player_hash[player_name] = [
            {
              "turn: 1": {
                turn_a: score
              }
            }
          ]
        end
      end
    end

    player_hash
  end
end