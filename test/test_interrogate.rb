require 'minitest_helper'

describe Interrogate do
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
        Interrogate::TTY::CODE::UP,
        Interrogate::TTY::CODE::SPACE,
        Interrogate::TTY::CODE::DOWN,
        Interrogate::TTY::CODE::SPACE,
        Interrogate::TTY::CODE::RETURN
      ]
      input_proc = Proc.new { input.shift }

      result = Interrogate::IN.stub :getch, input_proc do
        question = Interrogate::CheckboxList.new(message, choices)
        question.ask()
      end

      assert_equal result, [
        { label: "horrible", value: [1,2,3] },
        { label: "good", value: {sub: 1} }
      ]
    end
  end
end
