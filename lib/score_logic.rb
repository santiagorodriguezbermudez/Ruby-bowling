class ScoreLogic
  attr_reader :player, :score

  def initialize(args)
    @player = args[:player]
    @score = args[:score]
  end

  def compute_score
    array_score = []

    @score.each do |key|
      current_turn = key.to_s.split(' ')[1].to_i
      current_turn_scores = @score[('turn: ' + current_turn.to_s).to_sym]
      next_turn_scores = @score[('turn: ' + (current_turn + 1).to_s).to_sym]
      after_next_turn_scores = @score[('turn: ' + (current_turn + 2).to_s).to_sym]

      score = if current_turn == 10
                calculate(current_turn_scores, next_turn_scores, after_next_turn_scores, true)
              else
                calculate(current_turn_scores, next_turn_scores, after_next_turn_scores, false)
              end

      array_score << score

      break if current_turn == 10
    end
    array_score
  end

  def print_pinfalls
    pinfalls = []
    @score.each do |key, turn|
      current_turn = key.to_s.split(' ')[1].to_i
      next_turn_scores = @score[('turn: ' + (current_turn + 1).to_s).to_sym]
      pinfalls << print_pinfall(turn) unless current_turn == 10
      pinfalls << print_last_pinfall(turn, next_turn_scores) if current_turn == 10
      break if current_turn == 10
    end
    pinfalls
  end

  private

  def calculate(current_turn, next_turn, after_next_turn, last_turn)
    first = clean_numbers(current_turn[:turn_a])
    second = clean_numbers(current_turn[:turn_b])

    if first == 10
      strike(next_turn, after_next_turn, last_turn)
    elsif first + second == 10
      spare(next_turn)
    else
      normal(current_turn)
    end

    @player.total_score
  end

  def strike(next_turn, after_next_turn, last_turn)
    @player.total_score += if clean_numbers(next_turn[:turn_a]) < 10 || last_turn
                             10 + clean_numbers(next_turn[:turn_a]) + clean_numbers(next_turn[:turn_b])
                           else
                             20 + after_next_turn[:turn_a]
                           end
  end

  def spare(next_turn)
    next_first = clean_numbers(next_turn[:turn_a])
    @player.total_score += 10 + next_first
  end

  def normal(turn)
    first = clean_numbers(turn[:turn_a])
    second = clean_numbers(turn[:turn_b])
    @player.total_score += first + second
  end

  def clean_numbers(turn)
    turn == 'F' ? 0 : turn
  end

  def print_pinfall(turn)
    if clean_numbers(turn[:turn_a]) == 10
      ['', 'X']
    elsif clean_numbers(turn[:turn_a]) + clean_numbers(turn[:turn_b]) == 10
      [turn[:turn_a].to_s, '/']
    else
      [turn[:turn_a].to_s, turn[:turn_b].to_s]
    end
  end

  def print_last_pinfall(turn, next_turn)
    first_next = next_turn[:turn_a] == 10 ? 'X' : next_turn[:turn_a].to_s
    second_next = next_turn[:turn_b] == 10 ? 'X' : next_turn[:turn_b].to_s

    if clean_numbers(turn[:turn_a]) == 10
      ['X', first_next, second_next]
    elsif clean_numbers(turn[:turn_a]) + clean_numbers(turn[:turn_b]) == 10
      [turn[:turn_a].to_s, '/', first_next]
    else
      [turn[:turn_a].to_s, turn[:turn_b].to_s]
    end
  end
end
