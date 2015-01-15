$:.unshift File.expand_path("../../lib", __FILE__)

require "pp"
require "question"

choices = [
  { label: "red", value: {r: 255, g: 0, b: 0} },
  { label: "blue", value: "#0000FF" },
  "green" # You can also just pass a String or Number
]

pp Question.checkbox_list("What colors do you like", choices, default: choices[1..-1])
puts
pp Question.list("What is your FAVORITE color", choices)
puts
pp Question.input("What is your name?", default: ENV["USER"])
puts
pp Question.password("Enter something secret")
puts
pp Question.confirm("Do you understand")
