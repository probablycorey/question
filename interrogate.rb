# ◉◯

require 'bundler/setup'
require 'colorize'
require 'readline'

LIST = [
  'corey', 'awesome'
]

class Interrogate
  def initialize
    @output = $stdout
  end

  def say(statement)
    @output.print(statement)
  end

  def ask(question)
    question = "? ".cyan + question + ": "
    answer = Readline.readline(question, true)
    puts answer.strip
  end

  def list(question)
    question = "? ".cyan + question + ": "
    while buf = Readline.readline(question)
      puts buf
    end
  end
end
# Charm.prototype.cursor = function (visible) {
#   this.write(encode(visible ? '[?25h' : '[?25l'));
#   return this;
#   };

Interrogate.new.list('What is my name')
