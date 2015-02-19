module Question
  class Confirm
    def initialize(question, default:true)
      @question = question
      @finished = false
      @default = default
      @answer = nil
    end

    def ask
      while @answer.nil?
        TTY.interactive do
          render
          handle_input
        end
      end

      render

      @answer
    end

    def handle_input
      case TTY.input
      when TTY::CODE::SIGINT
        exit 130
      when TTY::CODE::RETURN
        @answer = @default
      when /y/i
        @answer = true
      when /n/i
        @answer = false
      else
        print TTY::CODE::BEEP
      end
    end

    def render
      print "? ".colorize(:cyan)
      print @question
      print ": "
      if @answer.nil?
        default_message = @default ? "(Y/n) " : "(y/N) "
        print default_message.colorize(:light_white)
      else
        answer_message = @answer ? "Yes" : "No"
        print answer_message.colorize(:blue)
      end

      print "\n"
    end

    def colorized_question
      colorized_question = "? ".cyan
      colorized_question += @question
      colorized_question += ": "
    end
  end
end
