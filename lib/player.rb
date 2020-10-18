class Player
  attr_reader :name
  attr_accessor :total_score
  def initialize(name)
    @name = name
    @total_score = 0
  end
end
