require_relative('../libs/utils')

def create_section(label)
  "[#{label}]"
end

def create_property(label, value)
  "#{label}=#{value}"
end

write_theme_file([
  create_section('Scheme'),
  create_property('Name', $metadata[:name]),
  create_property('ColorBackground', $metadata[:colors_hex][0]),
  create_property('ColorForeground', $metadata[:colors_hex][7]),
  create_property('ColorPalette', create_color_strings(lambda {
    |_color_ansi, color_hex, _color_name| color_hex
  }).join(";"))
].join("\n") + "\n")
