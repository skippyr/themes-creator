require_relative('../libs/utils')

def create_section(name)
  "#{name}:"
end

def create_subsection(name)
  "  #{name}:"
end

def create_property(label, value)
  "    #{label}: #{value}"
end

def create_color_properties(is_bright_group)
  create_color_strings(lambda {
    |_color_ansi, color_hex, color_name|
    create_property(color_name, "\"#{color_hex}\"")
  }, use_groups: true, is_bright_group: is_bright_group)
end

write_theme_file([
  create_section('colors'),
  create_subsection('primary'),
  create_property('background', "\"#{$metadata[:colors_hex][0]}\""),
  create_property('foreground', "\"#{$metadata[:colors_hex][7]}\""),
  create_subsection('cursor'),
  create_property('cursor', 'CellForeground'),
  create_property('text', 'CellBackground'),
  create_subsection('selection'),
  create_property('cursor', 'CellForeground'),
  create_property('text', 'CellBackground'),
  create_subsection('normal'),
  create_color_properties(false),
  create_subsection('bright'),
  create_color_properties(true)
].join("\n") + "\n")
