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
      @answer = Readline.readline(question + TTY::CODE::NOOP, true)
      @answer = @default if @default && @answer.length == 0

      @answer
    rescue Interrupt
      exit 1
    ensure
      print TTY::CODE::RESTORE
      print TTY::CODE::CLEAR_DOWN

      render
    end

    def render
      print colorized_question
      print @answer.green
      print "\n"
    end

    def colorized_question
      colorized_question = "? ".cyan
      colorized_question += @question
      colorized_question += ": "
    end
  end
end
