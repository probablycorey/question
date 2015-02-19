require "pp"

require_relative "../lib/question"

choices = [
  { label: "red", value: {r: 255, g: 0, b: 0} },
  { label: "blue", value: "#0000FF" },
  { label: "green", value: "green" }
]

# question = Question::CheckboxList.new("What colors do you like", choices, default: choices[1..-1])
# pp question.ask
#
# question = Question::List.new("What is your FAVORITE color", choices)
# pp question.ask
#
# question = Question::Input.new("What is your name?", default: ENV["USER"])
# pp question.ask
#
# question = Question::Password.new("Enter something secret")
# pp question.ask

question = Question::Confirm.new("Do you understand")
pp question.ask
