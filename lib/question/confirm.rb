module Question
  class Confirm
    def initialize(question, default:true)
      @question = question
      @finished = false
      @default = default
      @answer = nil
    end

    def ask
      print TTY::CODE::SAVE
      question = colorized_question
      if @default
        question += "(Y/n) ".light_white
      else
        question += "(y/N) ".light_white
      end

      # Use readline so keyboard shortcuts like alt-backspace work
      @answer = Readline.readline(question, true)
      @answer = if @answer =~ /^y/i
        true
      elsif @answer =~ /^n/i
        false
      else
        @default
      end

      render

      @answer
    rescue Interrupt
      exit 1
    end

    def render
      TTY.clear
      print colorized_question
      print (@answer ? "Yes" : "No").blue
      print "\n"
    end

    def colorized_question
      colorized_question = "? ".cyan
      colorized_question += @question
      colorized_question += ": "
    end
  end
end
