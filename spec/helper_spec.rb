require './lib/helpers'

describe Helper do
  Dir.chdir(File.dirname(__FILE__))
  let(:perfect_file) { File.open('./fixtures/test_input_perfect.txt') }


  describe '#validate_input' do
    puts perfect_file  
    it 'The input has one or more negative scores' do
      expect(Helper.validate_input(:perfect_file)).to eql(true)
    end

    it 'The input has scores higher than 10' do
      
    end

    it 'The input is empty' do
      
    end

    it 'The input has more than 10 throws per player' do
      
    end

    it 'The input has the incorrect format' do
      
    end

  end
end