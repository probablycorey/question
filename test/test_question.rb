require 'minitest_helper'

describe Question do
  describe "CheckboxList" do
    it "returns checked choices" do
      message = "How are you feeling"
      choices = [
        { label: "good", value: {sub: 1} },
        { label: "neutral", value: 0 },
        "horrible"
      ]

      input = [
        Question::TTY::CODE::UP,
        Question::TTY::CODE::SPACE,
        Question::TTY::CODE::DOWN,
        Question::TTY::CODE::SPACE,
        Question::TTY::CODE::RETURN
      ]
      result = fake_input(input) do
        question = Question::CheckboxList.new(message, choices)
        question.ask()
      end

      assert_equal result, [
        "horrible",
        { label: "good", value: {sub: 1} }
      ]
    end
  end

  describe "List" do
    it "returns checked choices" do

      message = "How are you feeling"
      choices = [
        { label: "good", value: {sub: 1} },
        { label: "neutral", value: 0 },
        "horrible"
      ]

      choices.each_with_index do |choice, index|
        input = [Question::TTY::CODE::RETURN]
        index.times { input.unshift Question::TTY::CODE::DOWN }
        result = fake_input(input) do
          question = Question::List.new(message, choices)
          question.ask()
        end
        assert_equal result, choice
      end
    end
  end
end
