require "io/console"
require "pp"
require "readline"
require "timeout"

require "colorize"

require "question/version"
require "question/tty"
require "question/checkbox_list"
require "question/list"
require "question/input"
require "question/password"
require "question/confirm"

module Question
  def self.checkbox_list(*args)
    CheckboxList.new(*args).ask
  end

  def self.list(*args)
    List.new(*args).ask
  end

  def self.input(*args)
    Input.new(*args).ask
  end

  def self.password(*args)
    Password.new(*args).ask
  end

  def self.confirm(*args)
    Confirm.new(*args).ask
  end
end
