require "pp"

require "interrogate"

choices = [
  { label: "red", value: {r: 255, g: 0, b: 0} },
  { label: "blue", value: "#0000FF" },
  { label: "green", value: "green" }
]

question = Interrogate::CheckboxList.new("What colors do you like", choices, default: choices[1..-1])
pp question.ask

question = Interrogate::List.new("What is your FAVORITE color", choices)
pp question.ask

question = Interrogate::Input.new("What is your name?", default: ENV["USER"])
pp question.ask

question = Interrogate::Password.new("Enter something secret")
pp question.ask

question = Interrogate::Confirm.new("Do you understand")
pp question.ask
