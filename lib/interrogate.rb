require "io/console"
require "pp"
require "readline"
require "timeout"

require "colorize"

require "interrogate/version"
require "interrogate/tty"
require "interrogate/checkbox_list"
require "interrogate/list"
require "interrogate/input"
require "interrogate/password"
require "interrogate/confirm"

module Interrogate
  IN ||= $stdin
  OUT ||= $stdout
end
