require_relative('../libs/utils')

def create_property(label, value)
  ".*#{label}: #{value}"
end

write_theme_file([
  create_property('background', $metadata[:colors_hex][0]),
  create_property('foreground', $metadata[:colors_hex][7]),
  create_color_strings(lambda {
    |color_ansi, color_hex, _color_name|
    create_property("color#{color_ansi}", color_hex)
  })
].join("\n") + "\n")
