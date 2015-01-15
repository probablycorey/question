$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'question'

require 'minitest/autorun'

def fake_input(input, &block)
  input_proc = proc { input.shift }
  $stdin.stub :getch, input_proc do
    block.call
  end
end
