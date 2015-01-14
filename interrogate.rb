require "bundler/setup"

require "io/console"
require "pp"
require "readline"
require "timeout"

require "colorize"

require_relative "./tty"
require_relative "./checkbox_list"
require_relative "./list"
require_relative "./input"
require_relative "./password"
require_relative "./confirm"

choices = [
  { label: "good", value: 1 },
  { label: "neutral", value: 0 },
  { label: "horrible", value: -1 }
]

question = CheckboxList.new("How are you", choices, default: choices[1..-1])
# question = List.new("How are you", choices)
# question = Input.new("How are you")
# question = Password.new("How are you")
# question = Confirm.new("How are you")

pp question.ask
