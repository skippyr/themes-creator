require_relative('../libs/utils')

def create_section(label)
  "[#{label}]"
end

def create_subsection(label)
  "  [[#{label}]]"
end

def create_property(label, value)
  "    #{label} = #{value}"
end

write_theme_file([
  create_section('profiles'),
  create_subsection('default'),
  create_property('background_color', "\"#{$metadata[:colors_hex][0]}\""),
  create_property('foreground_color', "\"#{$metadata[:colors_hex][7]}\""),
  create_property('cursor_fg_color', "\"#{$metadata[:colors_hex][0]}\""),
  create_property('cursor_bg_color', "\"#{$metadata[:colors_hex][7]}\""),
  create_property('cursor_color_default', 'False'),
  create_property('palette', "\"#{create_color_strings(lambda {
    |_color_ansi, color_hex, _color_name| color_hex
  }).join(":")}\"" )
].join("\n") + "\n")
