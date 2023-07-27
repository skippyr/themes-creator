require_relative('../libs/utils')

write_theme_file("#!/usr/bin/env bash
[[ ${TERM} != \"linux\" ]] && exit
apply_color() {
  echo -en \"\\\\e]P${1}${2}\"
}
#{create_color_strings(lambda {
  |color_ansi, color_hex, _color_name|
  "apply_color #{color_ansi.to_s(16)} #{color_hex[1..]}"
}).join("\n")}\n", is_executable: true)
