#!/usr/bin/env ruby
require_relative '../lib/player.rb'
require_relative '../lib/game.rb'
require_relative '../lib/score.rb'
require_relative '../lib/helpers.rb'

# Make the path relative the current script
Dir.chdir(File.dirname(__FILE__))

# Capture the file data
begin
  file_data = File.read(ARGV[0])
rescue
  if ARGV[0]
    puts "Error: The file #{ARGV[0]} could not be found"
  else
    puts "Error: Empty file. Please run the program with an existing file"
  end
  exit
end

# Throw error in case the input is not valid
begin
  Helper.validate_input(file_data)
rescue => exception
  puts "Error #{exception}. Please review your input and try again"
  exit
end

