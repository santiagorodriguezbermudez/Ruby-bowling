#!/usr/bin/env ruby
require_relative '../lib/player.rb'
require_relative '../lib/score_logic.rb'
require_relative '../lib/helpers.rb'

# Print output
def print_output(data)
  string = 'Frame'.ljust(10)
  string = (1...10).inject(string) { |string, i| string + "#{i}".ljust(8) }
  string += "10\n"
  data.each do |player_name, score|
    current_player = Player.new(player_name)
    current_score = ScoreLogic.new({ player: current_player, score: score })
    string += current_player.name + "\n"
    string += 'Pinfalls'.ljust(10)
    string = current_score.print_pinfalls.inject(string) {|string, pinfall| string + "#{pinfall[0]}   #{pinfall[1]}".ljust(8)}
    string += current_score.print_pinfalls[-1][-1].to_s if current_score.print_pinfalls[-1].length == 3
    string += "\nScore".ljust(11)
    string = current_score.compute_score.inject(string) {|string, score| string + "#{score}".ljust(8)}
    string += "\n"
  end
  string
end

# Make the path relative the current script
Dir.chdir(File.dirname(__FILE__))

# Capture the file data
begin
  file_data = File.read(ARGV[0])
rescue StandardError
  if ARGV[0]
    puts "Error: The file #{ARGV[0]} could not be found"
  else
    puts 'Error: Empty file. Please run the program with an existing file'
  end
  exit
end

#Validate data
if Helper.validate_input(file_data) == true
  #Organize data
  organized_data = Helper.organize_data(file_data)

  #Print data
  puts print_output(organized_data)
else
  puts Helper.validate_input(file_data)
end
