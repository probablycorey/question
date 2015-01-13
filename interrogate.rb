require 'bundler/setup'
require 'pp'

require_relative "./checkbox"

choices = [
  { label: "good", value: 1 },
  { label: "neutral", value: 0 },
  { label: "horrible", value: -1 }
]

checkbox = Checkbox.new("How are you", choices)
result = checkbox.ask

pp result
