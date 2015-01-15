module Question
  class CheckboxList
    def initialize(question, choices, default: [])
      @question = question
      @choices = choices
      @active_index = 0
      @finished = false
      @modified = false

      default_values = default.map { |choice| value_for_choice(choice) }
      @selected_choices = choices.select do |choice|
        default_values.include? value_for_choice(choice)
      end
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
        render # render the results a final time and clear the screen
      end

      @selected_choices
    end

    def handle_input
      case TTY.input
      when TTY::CODE::SIGINT
        exit 130
      when TTY::CODE::RETURN
        @finished = true
      when TTY::CODE::DOWN
        @active_index += 1
        @active_index = 0 if @active_index >= @choices.length
      when TTY::CODE::UP
        @active_index -= 1
        @active_index = @choices.length - 1 if @active_index < 0
      when TTY::CODE::SPACE
        @modified = true
        active_choice = @choices[@active_index]
        if @selected_choices.include? active_choice
          @selected_choices.delete(active_choice)
        else
          @selected_choices.push(active_choice)
        end
      end
    end

    def instructions
      "(Use <space>, <up>, <down> – Press <enter> when finished)"
    end

    def render
      TTY.clear
      print "? ".cyan
      print @question
      print ": "
      if @finished
        print @selected_choices.map { |choice| label_for_choice(choice) }.join(", ").green
      elsif @modified
        print @selected_choices.map { |choice| label_for_choice(choice) }.join(", ")
      else
        print instructions.light_white
      end
      print "\n"

      unless @finished
        @choices.each_with_index do |choice, index|
          print index == @active_index ? TTY::UI::SELECTED : TTY::UI::UNSELECTED
          print " "
          if @selected_choices.include?(choice)
            print TTY::UI::CHECKBOX_CHECKED.green
          else
            print TTY::UI::CHECKBOX_UNCHECKED.red
          end
          print "  "
          print label_for_choice(choice)
          print "\n"
        end
      end
    end
  end
end
