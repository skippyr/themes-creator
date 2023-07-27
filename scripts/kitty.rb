require_relative('libs/utils')

def create_metadata_comment(label, value)
  "## #{label}: #{value}"
end

def create_property(name, value)
  "#{name} #{value}"
end

write_theme_file([
  create_metadata_comment('name', $metadata[:name]),
  create_metadata_comment('author', $metadata[:author]),
  create_metadata_comment('license', $metadata[:license]),
  create_metadata_comment('upstream', $metadata[:upstream]),
  create_property('background', $metadata[:colors_hex][0]),
  create_property('foreground', $metadata[:colors_hex][7]),
  create_property('cursor', $metadata[:colors_hex][7]),
  create_property('cursor_text_color', $metadata[:colors_hex][0]),
  create_property('selection_background', $metadata[:colors_hex][7]),
  create_property('selection_foreground', $metadata[:colors_hex][0]),
  create_property('active_tab_background', $metadata[:colors_hex][7]),
  create_property('active_tab_foreground', $metadata[:colors_hex][0]),
  create_property('inactive_tab_background', $metadata[:colors_hex][0]),
  create_property('inactive_tab_foreground', $metadata[:colors_hex][7]),
  create_property('active_border_color', $metadata[:colors_hex][2]),
  create_property('inactive_border_color', $metadata[:colors_hex][0]),
  create_property('url_color', $metadata[:colors_hex][4]),
].join("\n") + "\n" + create_color_strings(lambda {
  |color_ansi, color_hex, _color_name| "color#{color_ansi} #{color_hex}"
}).join("\n") + "\n")
