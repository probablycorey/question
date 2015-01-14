module Question
  class Password
    def initialize(question)
      @question = question
      @finished = false
      @finished = false
      @answer = ""
    end

    def ask
      TTY.interactive do
        while !@finished
          render
          handle_input
        end
      end
      render

      @answer
    end

    def handle_input
      case input = TTY.input
      when TTY::CODE::SIGINT
        exit 130
      when TTY::CODE::RETURN
        @finished = true
      when TTY::CODE::BACKSPACE, TTY::CODE::DELETE
        @answer.chop! unless @answer.length == 0
      when /^[^\e]/
        @answer += input
      end
    end

    def render
      obscured_password = TTY::UI::SECURE * @answer.length
      TTY.clear
      print "? ".colorize(:cyan)
      print @question
      print ": "
      print @finished ? obscured_password.colorize(:blue) : obscured_password
      print "\n"
    end
  end
end
