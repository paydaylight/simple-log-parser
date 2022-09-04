# frozen_string_literal: true

class String
  RED_COLOR_CODE = 31
  YELLOW_COLOR_CODE = 33
  BLUE_COLOR_CODE = 34

  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(RED_COLOR_CODE)
  end

  def yellow
    colorize(YELLOW_COLOR_CODE)
  end

  def blue
    colorize(BLUE_COLOR_CODE)
  end
end
