
require "io/console"
require "pp"
require "readline"
require "timeout"

require "colorize"

require "interrogate/version"
require "interrogate/tty"
require "interrogate/checkbox_list"
require "interrogate/list"
require "interrogate/input"
require "interrogate/password"
require "interrogate/confirm"

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
