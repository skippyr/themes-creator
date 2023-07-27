require_relative('../libs/utils')

def create_block(label)
  "[#{label}]"
end

def create_property(label, value)
  "#{label}=#{value}"
end

def create_color_blocks(label, color_hex)
  blocks = []
  suffixes = ["", "Faint", "Intense"]
  suffixes.each() do |suffix|
    blocks.push(create_block("#{label}#{suffix}"))
    blocks.push(create_property('Color', color_hex))
  end
  blocks
end

write_theme_file([
  create_block('General'),
  create_property('Description', $metadata[:name]),
  create_color_blocks('Background', $metadata[:colors_hex][0]),
  create_color_blocks('Foreground', $metadata[:colors_hex][7]),
  create_color_strings(lambda {
    |color_ansi, color_hex, _color_name|
    create_color_blocks("Color#{color_ansi}", color_hex)
  })
].join("\n") + "\n")
