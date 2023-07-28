require_relative('../libs/utils')

def to_kebak_case(name)
  name.downcase().gsub(/[ _]/, '-')
end

write_theme_file(":root {
#{create_color_strings(lambda {
  |color_ansi, color_hex, color_name|
  "  --#{to_kebak_case($metadata[:name])}-#{color_name}: #{color_hex};"
}, use_groups: true).join("\n")}
}\n")

