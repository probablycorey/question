module Question
  class List
    def initialize(question, choices)
      @question = question
      @choices = choices
      @active_index = 0
      @finished = false
    end

    def ask
      while !@finished
        TTY.interactive do
          render
          handle_input
        end
      end
      render # render the results a final time

      @choices[@active_index]
    end

    def handle_input
      case TTY.input
      when TTY::CODE::SIGINT
        exit 130
      when TTY::CODE::RETURN, TTY::CODE::SPACE
        @finished = true
      when TTY::CODE::DOWN
        @active_index += 1
        @active_index = 0 if @active_index >= @choices.length
      when TTY::CODE::UP
        @active_index -= 1
        @active_index = @choices.length - 1 if @active_index < 0
      end
    end

    def instructions
      "(Press <enter> when to make selection)"
    end

    def render
      print "? ".colorize(:cyan)
      print @question
      print ": "
      if @finished
        print @choices[@active_index][:label].colorize(:green)
      else
        print instructions.colorize(:light_white)
      end
      print "\n"

      unless @finished
        @choices.each_with_index do |choice, index|
          print index == @active_index ? TTY::UI::SELECTED : TTY::UI::UNSELECTED
          print " "
          print choice[:label]
          print "\n"
        end
      end
    end
  end
end
