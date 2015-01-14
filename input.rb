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
    question += "(#{@default}) ".colorize(:light_white) if @default
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
    print @answer.colorize(:blue)
    print "\n"
  end

  def colorized_question
    colorized_question = "? ".colorize(:cyan)
    colorized_question += @question
    colorized_question += ": "
  end
end
