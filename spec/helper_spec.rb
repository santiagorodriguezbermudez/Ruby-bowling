require './lib/helpers'

describe Helper do
  Dir.chdir(File.dirname(__FILE__))
  
  
  describe '#validate_input' do
    it 'The input has one or more negative scores' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_negative.txt'))).to eql(false)
    end

    it 'The input has scores higher than 10' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_invalid.txt'))).to eql(false)
    end

    it 'The input is empty' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_empty.txt'))).to eql(false)
    end

    it 'The input has more than 10 throws per player' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_more_turns.txt'))).to eql(false)
    end

    it 'The input has the incorrect format' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_wrong_format.txt'))).to eql(false)
    end

    it 'The input is correct when perfect score' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_perfect.txt'))).to eql(true)
    end

    it 'The input is correct when 0 score' do
      expect(Helper.validate_input(File.read('./fixtures/test_input_zero.txt'))).to eql(true)
    end

  end
end