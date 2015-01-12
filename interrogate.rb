# ◉◯

require 'bundler/setup'
require 'colorize'
require 'readline'
require 'tempfile'

tmp_file = Tempfile.new('hello')

Readline.output = File.open(tmp_file, "w+")

count = 0
Thread.new do
  input = open(tmp_file, "r+")
  while true
    character = input.getc
    if character == "!"
      count += 1
      $stdout.write(character)
      $stdout.flush
    end
  end
end

begin
  while line = Readline.readline("", true)
    count = 0
    $stdout.write(count)
    $stdout.flush
  end
rescue EOFError
  puts "Exiting..."
end
