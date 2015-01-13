require 'bundler/setup'

require 'pp'

require 'colorize'
require 'io/console'
require 'timeout'

require_relative("./tty")
require_relative "./checkbox"
require_relative "./radio"

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
result = question.ask

pp result
