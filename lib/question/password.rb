module Question
  class Password
    def initialize(question)
      @question = question
      @finished = false
      @finished = false
      @answer = ""
    end

    def ask
      while !@finished
        TTY.interactive do
          render
          handle_input
        end
      end
      render

      @answer
    end

    def handle_input
      case input = TTY.input
      when TTY::CODE::SIGINT, TTY::CODE::ESCAPE
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
      print "? ".cyan
      print @question
      print ": "
      print @finished ? obscured_password.green : obscured_password
      print "\n"
      print TTY::CODE::NOOP unless @finished
    end
  end
end
