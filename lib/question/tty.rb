module Question
  class TTY
    module CODE
      SPACE = " "
      TAB = "\t"
      RETURN = "\r"
      LINEFEED = "\n"
      ESCAPE = "\e"
      BEEP = "\a"
      UP = "\e[A"
      DOWN = "\e[B"
      RIGHT = "\e[C"
      LEFT = "\e[D"
      BACKSPACE = "\b"
      DELETE = "\e[3"

      CTRL_J = "\x0A"
      CTRL_N = "\x0E"
      CTRL_K = "\x0B"
      CTRL_P = "\x10"
      SIGINT = "\x03"

      HIDE = "\e[?25l"
      SHOW = "\e[?25h"
      CLEAR_DOWN = "\e[0J"
      SAVE = "\e7"
      RESTORE = "\e8"

      NOOP = "\e[0n" # Used in tests to determine if a question requires input.
    end

    module UI
      SECURE = "•"
      SELECTED = "‣"
      UNSELECTED = " "
      CHECKBOX_CHECKED = "⬢"
      CHECKBOX_UNCHECKED = "⬡"
    end

    def self.interactive(&block)
      begin
        print TTY::CODE::SAVE
        sync_value = $stdout.sync
        $stdout.sync = true
        print TTY::CODE::HIDE
        block.call
      ensure
        print TTY::CODE::SHOW
        print TTY::CODE::RESTORE
        print TTY::CODE::CLEAR_DOWN
        $stdout.sync = sync_value
      end
    end

    def self.input
      input = $stdin.getch
      return input unless input == "\e"
      begin
        Timeout.timeout(0.01) do
          input += $stdin.getch
          input += $stdin.getch
        end
      rescue Timeout::Error
      end
      input
    end
  end
end
