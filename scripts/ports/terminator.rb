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
  create_property('background-color', "\"#{$metadata[:colors_hex][0]}\""),
  create_property('foreground-color', "\"#{$metadata[:colors_hex][7]}\""),
  create_property('palette', "\"#{create_color_strings(lambda {
    |_color_ansi, color_hex, _color_name| color_hex
  }).join(":")}\"" )
].join("\n") + "\n")
