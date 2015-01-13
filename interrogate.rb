require 'bundler/setup'
require 'colorize'
require 'io/console'
require 'timeout'

module KEYS
  SPACE = " "
  TAB = "\t"
  RETURN = "\r"
  LINEFEED = "\n"
  ESCAPE = "\e"
  UP = "\e[A"
  DOWN = "\e[B"
  RIGHT = "\e[C"
  LEFT = "\e[D"
  BACKSPACE = "\177"
  SIGINT = "\003"
end

module ANSI
  HIDE = "\e[?25l"
  SHOW = "\e[?25h"
  CLEAR_DOWN = "\e[0J"
end

OUTPUT = $stdout
INPUT = $stdin

def get_input
  input = INPUT.getch
  if input == "\e"
    Timeout.timeout(0.01) do
      input += INPUT.getch
      input += INPUT.getch
    end
  end
  input
rescue Timeout::Error
  input
end

def hide_cursor(&block)
  sync_value = OUTPUT.sync
  OUTPUT.sync = true

  OUTPUT.print ANSI::HIDE
  block.call()
  OUTPUT.print ANSI::SHOW
  OUTPUT.sync = sync_value
end

def ask(question)
  OUTPUT.print question + ": "

  hide_cursor do
    loop do
      input = get_input
      case input
      when KEYS::SIGINT
        exit 130
      when KEYS::RETURN
        puts "DONE!"
        exit 1
      when KEYS::ESCAPE
        print "ESCAPE!"
      when KEYS::DOWN
        print KEYS::DOWN
        print "HI"
        print KEYS::UP
      when KEYS::UP
        print "!"
        print ANSI::CLEAR_DOWN
      when /^[^\e]/
        OUTPUT.print input
      end
    end
  end
end

ask "How are you"
