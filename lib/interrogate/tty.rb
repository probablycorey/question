module Interrogate
  class TTY
    module CODE
      SPACE = " "
      TAB = "\t"
      RETURN = "\r"
      LINEFEED = "\n"
      ESCAPE = "\e"
      UP = "\e[A"
      DOWN = "\e[B"
      RIGHT = "\e[C"
      LEFT = "\e[D"
      BACKSPACE = "\b"
      DELETE = "\e[3"
      SIGINT = "\003"

      HIDE = "\e[?25l"
      SHOW = "\e[?25h"
      CLEAR_DOWN = "\e[0J"
      SAVE = "\e7"
      RESTORE = "\e8"
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
        $stdout.sync = sync_value
      end
    end

    def self.clear
      print TTY::CODE::RESTORE
      print TTY::CODE::CLEAR_DOWN
    end

    def self.input
      input = IN.getch
      return input unless input == "\e"
      begin
        Timeout.timeout(0.01) do
          input += IN.getch
          input += IN.getch
        end
      rescue Timeout::Error
      end
      input
    end
  end
end
