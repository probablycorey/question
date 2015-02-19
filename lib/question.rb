require "io/console"
require "pp"
require "readline"
require "timeout"

require "colorize"

require_relative "./question/version"
require_relative "./question/tty"
require_relative "./question/checkbox_list"
require_relative "./question/list"
require_relative "./question/input"
require_relative "./question/password"
require_relative "./question/confirm"

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
