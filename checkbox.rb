require 'colorize'
require 'io/console'
require 'timeout'

module ESCAPE_CODE
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

  HIDE = "\e[?25l"
  SHOW = "\e[?25h"
  CLEAR_DOWN = "\e[0J"
  SAVE = "\e7"
  RESTORE = "\e8"
end

module UI
  SELECTED = "‣"
  UNSELECTED = " "
  CHECKBOX_CHECKED = "⬢"
  CHECKBOX_UNCHECKED = "⬡"
end

class Checkbox
  def initialize(question, choices)
    @question = question
    @choices = choices
    @selected_index = 0
    @result = []
    @finished = false
  end

  def ask
    print ESCAPE_CODE::SAVE
    choose
    @result
  end

  def choose()
    begin
      sync_value = $stdout.sync
      $stdout.sync = true
      $stdout.print ESCAPE_CODE::HIDE

      while !@finished
        render
        handle_input
      end
    ensure
      $stdout.print ESCAPE_CODE::SHOW
      $stdout.sync = sync_value
    end
  end

  def handle_input
    case input
    when ESCAPE_CODE::SIGINT
      exit 130
    when ESCAPE_CODE::RETURN
      @finished = true
    when ESCAPE_CODE::DOWN
      @selected_index += 1
      @selected_index = 0 if @selected_index >= @choices.length
    when ESCAPE_CODE::UP
      @selected_index -= 1
      @selected_index = @choices.length - 1 if @selected_index < 0
    when ESCAPE_CODE::SPACE
      selected_choice = @choices[@selected_index]
      if @result.include? selected_choice
        @result.delete(selected_choice)
      else
        @result.push(selected_choice)
      end
    end
  end

  def render
    clear
    puts @question
    @choices.each_with_index do |choice, index|
      print index == @selected_index ? UI::SELECTED : UI::UNSELECTED
      print " "
      print @result.include?(choice) ? UI::CHECKBOX_CHECKED : UI::CHECKBOX_UNCHECKED
      print "  "
      print choice[:label]
      print "\n"
    end
  end

  def clear
    print ESCAPE_CODE::RESTORE
    print ESCAPE_CODE::CLEAR_DOWN
  end

  def input
    input = $stdin.getch
    return input unless input == "\e"
    begin
      Timeout.timeout(0.01) do
        input += $stdin.getch
        input += $stdin.getch
      end
    rescue Timeout::Error
    end
    input
  end
end
