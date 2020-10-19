class ScoreLogic
  attr_reader :player, :score

  def initialize(args)
    @player = args[:player]
    @score = args[:score]
  end

  def get_score
    array_score = []

    @score.each do |key, value|

      current_turn = key.to_s.split(' ')[1].to_i
      next_turn = current_turn + 1
      next_turn_scores = @score[('turn: ' + next_turn.to_s).to_sym]

      
      first = value[:turn_a] == 'F' ? 0 : value[:turn_a]
      second = value[:turn_b] == 'F' ? 0 : value[:turn_b]

      if first == 10 # Strike
        if next_turn_scores[:turn_a] < 10 || current_turn == 10
          @player.total_score += 10 + next_turn_scores[:turn_a] + next_turn_scores[:turn_b]
        else
          next_turn += 1
          next_turn_scores = @score[('turn: ' + next_turn.to_s).to_sym]
          @player.total_score += 10 + 10 + next_turn_scores[:turn_a]
        end
      elsif first + second == 10 # Spare
        @player.total_score += 10 + (next_turn_scores[:turn_a] == 'F' ? 0 : next_turn_scores[:turn_a])
      else #Normal score
        @player.total_score += first + second
      end 

      array_score << @player.total_score
      break if current_turn == 10
    end
    array_score
  end
  
  def get_pinfalls
    pinfalls = []
    @score.each do |key, value|
      first = value[:turn_a] == 'F' ? 0 : value[:turn_a]
      second = value[:turn_b] == 'F' ? 0 : value[:turn_b]
      if key.to_s.split(' ')[1].to_i < 10
        if first == 10
          pinfalls << ['', 'X']
        elsif first + second == 10
          pinfalls << [value[:turn_a].to_s, '/']
        else
          pinfalls << [value[:turn_a].to_s, value[:turn_b].to_s]
        end
      elsif key.to_s.split(' ')[1].to_i == 10
        if first == 10
          bonus_turn_a = @score['turn: 11'.to_sym][:turn_a]
          bonus_turn_b = @score['turn: 11'.to_sym][:turn_b]
          bonus_turn_a = bonus_turn_a == 10 ? 'X': bonus_turn_a.to_s
          bonus_turn_b = bonus_turn_b == 10 ? 'X': bonus_turn_b.to_s
          pinfalls << ['X', bonus_turn_a, bonus_turn_b]
        elsif first + second == 10
          bonus_turn_a = @score['turn: 11'.to_sym][:turn_a] == 'F' ? 0 : @score['turn: 11'.to_sym][:turn_a]
          bonus_turn_a = bonus_turn_a == 10 ? 'X': bonus_turn_a.to_s
          pinfalls << [value[:turn_a].to_s, '/', @score['turn: 11'.to_sym][:turn_a]]
        else
          pinfalls << [value[:turn_a].to_s, value[:turn_b].to_s]
        end
      end
    end
    pinfalls
  end
end
