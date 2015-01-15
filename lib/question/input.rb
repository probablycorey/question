module Question
  class Input
    def initialize(question, default:nil)
      @question = question
      @finished = false
      @default = default
      @answer = nil
    end

    def ask
      print TTY::CODE::SAVE
      question = colorized_question
      question += "(#{@default}) ".light_white if @default

      # Use readline so keyboard shortcuts like alt-backspace work
      @answer = Readline.readline(question, true)
      @answer = @default if @default && @answer.length == 0

      render
      @answer
    rescue Interrupt
      exit 1
    end

    def render
      TTY.clear
      print colorized_question
      print @answer.blue
      print "\n"
    end

    def colorized_question
      colorized_question = "? ".cyan
      colorized_question += @question
      colorized_question += ": "
    end
  end
end
