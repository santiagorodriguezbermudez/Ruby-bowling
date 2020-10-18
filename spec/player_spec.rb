describe Player do
  let(:player_test) { Player.new('test_user') }

  describe 'The Class Player creates a proper Object' do
    it 'Creates the Player Object' do
      expect(player_test).to be_a Player
    end

    it 'Player has the correct attributes' do
      expect(player_test.name).to eql('test_user')
      expect(player_test.total_score).to eql(0)
    end
  end
end
