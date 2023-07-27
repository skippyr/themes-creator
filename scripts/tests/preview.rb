def create_color_ansi_label(color_ansi)
  color_ansi_as_string = color_ansi.to_s()
  color_ansi_as_string + ' ' * (3 - color_ansi_as_string.chars().length)
end

def create_colors_line(action)
  for color_ansi in 0..15
    print(action.call(color_ansi))
  end
  puts()
end

create_colors_line(lambda {|color_ansi| create_color_ansi_label(color_ansi)})
create_colors_line(lambda {|color_ansi| "\x1b[48;5;#{color_ansi}m   \x1b[0m"})
create_colors_line(lambda {|color_ansi| "\x1b[38;5;#{color_ansi}mXyW\x1b[0m"})
