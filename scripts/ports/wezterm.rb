require_relative('../libs/utils')

def create_section(label)
  "[#{label}]"
end

def create_property(label, value)
  "#{label} = #{value}"
end

def create_colors_array(label, is_bright_group)
  create_property(label, "[\n#{create_color_strings(lambda {
    |_color_ansi, color_hex, _color_name|
    "    \"#{color_hex}\""
  }, use_groups: true, is_bright_group: is_bright_group).join(",\n")}\n]")
end

write_theme_file([
  create_section('metadata'),
  create_property('name', "\"#{$metadata[:name]}\""),
  create_property('author', "\"#{$metadata[:author]}\""),
  create_property('origin_url', "\"#{$metadata[:upstream]}\""),
  create_section('colors'),
  create_property('background', "\"#{$metadata[:colors_hex][0]}\""),
  create_property('foreground', "\"#{$metadata[:colors_hex][7]}\""),
  create_property('cursor_bg', "\"#{$metadata[:colors_hex][7]}\""),
  create_property('cursor_fg', "\"#{$metadata[:colors_hex][0]}\""),
  create_property('selection_bg', "\"#{$metadata[:colors_hex][7]}\""),
  create_property('selection_fg', "\"#{$metadata[:colors_hex][0]}\""),
  create_colors_array('ansi', false),
  create_colors_array('brights', true)
].join("\n") + "\n")
