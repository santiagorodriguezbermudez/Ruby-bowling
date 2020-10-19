describe ScoreLogic do
  Dir.chdir(File.dirname(__FILE__))

  describe 'The Class ScoreLogic creates a proper Object' do
    test_score = ScoreLogic.new({ player: Player.new('test_user') })
    it 'Creates a Score Logic Object' do
      expect(test_score).to be_a ScoreLogic
    end
  end

  describe '#get_score' do
    data = Helper.organize_data(File.read('./fixtures/test_input_perfect.txt'))
    player_name, score = data.first
    player = Player.new(player_name)
    score = ScoreLogic.new({ player: Player.new(player), score: score})
    
    it 'It returns the perfect score' do
      expect(score.get_score).to eql([30, 60, 90, 120, 150, 180, 210, 240, 270, 300])
    end

    it 'It returns the perfect pinfall' do
      expect(score.get_pinfalls).to eql([['', 'X'], ['', 'X'], ['', 'X'], ['', 'X'], ['', 'X'], ['', 'X'], ['', 'X'], ['', 'X'], ['', 'X'], ['', 'X']])
    end

    it 'The player has the the perfect score' do
      expect(player.total_score).to eql(300)
    end

    it 'It returns a zero score' do
      data = Helper.organize_data(File.read('./fixtures/test_input_zero.txt'))
      player_name, score = data.first
      player = Player.new(player_name)
      score = ScoreLogic.new({ player: Player.new(player), score: score})

      expect(score.get_score).to eql([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    end

    it 'It returns a partial score' do
      data = Helper.organize_data(File.read('./fixtures/test_input.txt'))
      player_name, score = data.first
      player = Player.new(player_name)
      score = ScoreLogic.new({ player: Player.new(player), score: score})

      expect(score.get_score).to eql([18, 26])
    end
  end
end
