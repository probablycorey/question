module Question
  class List
    def initialize(question, choices)
      @question = question
      @choices = choices
      @active_index = 0
      @finished = false
    end

    def label_for_choice(choice)
      choice.is_a?(Hash) ? choice[:label] : choice
    end

    def value_for_choice(choice)
      choice.is_a?(Hash) ? choice[:value] : choice
    end

    def ask
      TTY.interactive do
        while !@finished
          render
          handle_input
        end
        render
      end

      value_for_choice(@choices[@active_index])
    end

    def handle_input
      case TTY.input
      when TTY::CODE::SIGINT
        exit 130
      when TTY::CODE::RETURN, TTY::CODE::SPACE
        @finished = true
      when TTY::CODE::DOWN, TTY::CODE::CTRL_J, TTY::CODE::CTRL_N
        @active_index += 1
        @active_index = 0 if @active_index >= @choices.length
      when TTY::CODE::UP, TTY::CODE::CTRL_K, TTY::CODE::CTRL_P
        @active_index -= 1
        @active_index = @choices.length - 1 if @active_index < 0
      end
    end

    def instructions
      "(Press <enter> to select item)"
    end

    def render
      TTY.clear
      print "? ".cyan
      print @question
      print ": "
      if @finished
        print label_for_choice(@choices[@active_index]).green
      else
        print instructions.light_black
      end
      print "\n"

      unless @finished
        @choices.each_with_index do |choice, index|
          print index == @active_index ? TTY::UI::SELECTED.green : TTY::UI::UNSELECTED
          print " "
          if index == @active_index
            print label_for_choice(choice).green
          else
            print label_for_choice(choice)
          end
          print "\n"
        end
      end
    end
  end
end
