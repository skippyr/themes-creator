require_relative('libraries/io')

def apply_color(ansi_hex, hex)
  "echo -en #{quote("\\\\e]P#{ansi_hex}#{hex[1..]}")}"
end

metadata = parse_metadata()
write_theme_file(__FILE__, "#!/usr/bin/env bash
[[ ${TERM} != \"linux\" ]] && exit
#{apply_color(0, metadata[:colors][0])}
#{apply_color(1, metadata[:colors][1])}
#{apply_color(2, metadata[:colors][2])}
#{apply_color(3, metadata[:colors][3])}
#{apply_color(4, metadata[:colors][4])}
#{apply_color(5, metadata[:colors][5])}
#{apply_color(6, metadata[:colors][6])}
#{apply_color(7, metadata[:colors][7])}
#{apply_color(8, metadata[:colors][4])}
#{apply_color(9, metadata[:colors][1])}
#{apply_color("a", metadata[:colors][2])}
#{apply_color("b", metadata[:colors][3])}
#{apply_color("c", metadata[:colors][4])}
#{apply_color("d", metadata[:colors][5])}
#{apply_color("e", metadata[:colors][6])}
#{apply_color("f", metadata[:colors][7])}
")
