#!/usr/bin/env ruby
require_relative '../lib/player.rb'
require_relative '../lib/score_logic.rb'
require_relative '../lib/helpers.rb'

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

return Helper.validate_input(file_data) unless Helper.validate_input(file_data)

organized_data = Helper.organize_data(file_data)

puts organized_data