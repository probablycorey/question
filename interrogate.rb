require "bundler/setup"

require "io/console"
require "pp"
require "readline"
require "timeout"

require "colorize"

require_relative "./tty"
require_relative "./checkbox"
require_relative "./radio"
require_relative "./input"
require_relative "./password"

choices = [
  { label: "good", value: 1 },
  { label: "good", value: 1 },
  { label: "neutral", value: 0 },
  { label: "horrible", value: -1 },
  { label: "good", value: 1 },
  { label: "neutral", value: 0 },
  { label: "neutral", value: 0 },
  { label: "horrible", value: -1 },
  { label: "good", value: 1 },
  { label: "neutral", value: 0 },
  { label: "horrible", value: -1 }
]

question = Checkbox.new("How are you", choices)
question = Radio.new("How are you", choices)
question = Input.new("How are you")
question = Password.new("How are you")
pp question.ask
