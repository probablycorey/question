choices = [
  { label: "good", value: 1 },
  { label: "neutral", value: 0 },
  { label: "horrible", value: -1 }
]

question = Interrogate::CheckboxList.new("How are you", choices, default: choices[1..-1])
# question = Interrogate::List.new("How are you", choices)
# question = Interrogate::Input.new("How are you")
# question = Interrogate::Password.new("How are you")
# question = Interrogate::Confirm.new("How are you")

pp question.ask
