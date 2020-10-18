require './lib/helpers'
require './lib/player'
require './lib/score_logic'

describe Helper do
  Dir.chdir(File.dirname(__FILE__))

  describe '#organize_input' do
    it 'Organizes the array with player objects accordingly' do
      expect(Helper.organize_data(File.read('./fixtures/test_input.txt'))).to eql(
        {
          'Jeff' => { "turn: 1": { turn_a: 10, turn_b: 0 }, "turn: 2": { turn_a: 7, turn_b: 3 } },
          'John' => { "turn: 1": { turn_a: 3, turn_b: 7 } }
        }
      )
    end
  end

  describe '#validate_input' do
    it 'The input is empty' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_empty.txt')))
        .to eql('Error: The input file is empty')
    end

    it 'The input has the incorrect format' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_wrong_format.txt')))
        .to eql('Error: Incorrect format on input file. Check your score from Jeff on line: 8.')
    end

    it 'The input has more than 10 throws per player' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_more_turns.txt')))
        .to eql('Error: John has 1 more turn than the 10 allowed')
    end

    it 'The input is correct when perfect score' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_perfect.txt'))).to eql(true)
    end

    it 'The input is correct when 0 score' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_zero.txt'))).to eql(true)
    end
  end
end
