require_relative('../libs/utils')

def create_property(label, value)
  "    \"#{label}\": \"#{value}\""
end

write_theme_file("{\n#{[
  create_property('name', $metadata[:name]),
  create_property('background', $metadata[:colors_hex][0]),
  create_property('foreground', $metadata[:colors_hex][7]),
  create_property('cursorColor', $metadata[:colors_hex][7]),
  create_property('selectionBackground', $metadata[:colors_hex][7]),
  create_color_strings(lambda {
    |_color_ansi, color_hex, color_name| create_property(color_name, color_hex)
  }, use_bright_names: true, use_purple: true)
].join(",\n")}\n}\n")
