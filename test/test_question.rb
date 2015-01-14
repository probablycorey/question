require 'minitest_helper'

describe Question do
  describe "CheckboxList" do
    it "returns checked choices" do

      message = "How are you feeling"
      choices = [
        { label: "good", value: {sub: 1} },
        { label: "neutral", value: 0 },
        { label: "horrible", value: [1,2,3] }
      ]

      # Fake input
      input = [
        Question::TTY::CODE::UP,
        Question::TTY::CODE::SPACE,
        Question::TTY::CODE::DOWN,
        Question::TTY::CODE::SPACE,
        Question::TTY::CODE::RETURN
      ]
      input_proc = Proc.new { input.shift }

      result = Question::IN.stub :getch, input_proc do
        question = Question::CheckboxList.new(message, choices)
        question.ask()
      end

      assert_equal result, [
        { label: "horrible", value: [1,2,3] },
        { label: "good", value: {sub: 1} }
      ]
    end
  end
end
