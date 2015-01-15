$:.unshift File.expand_path("../../lib", __FILE__)

require "pp"
require "question"

choices = [
  { label: "red", value: {r: 255, g: 0, b: 0} },
  { label: "blue", value: "#0000FF" },
  "green" # You can also just pass a String or Number
]

pp Question.checkbox_list("What colors do you like", choices, default: choices[1..-1])
pp Question.list("What is your FAVORITE color", choices)
pp Question.input("What is your name?", default: ENV["USER"])
pp Question.password("Enter something secret")
pp Question.confirm("Do you understand")
