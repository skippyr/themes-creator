require_relative('libraries/io')

metadata = parse_metadata()
write_theme_file(__FILE__, "## name: #{metadata[:name]}
cursor #{metadata[:colors][7]}
cursor_text_color #{metadata[:colors][0]}
selection_background #{metadata[:colors][7]}
selection_foreground #{metadata[:colors][0]}
active_tab_background #{metadata[:colors][7]}
active_tab_foreground #{metadata[:colors][0]}
inactive_tab_background #{metadata[:colors][0]}
inactive_tab_foreground #{metadata[:colors][7]}
active_border_color #{metadata[:colors][2]}
inactive_border_color #{metadata[:colors][0]}
url_color #{metadata[:colors][4]}
background #{metadata[:colors][0]}
foreground #{metadata[:colors][7]}
color0 #{metadata[:colors][0]}
color1 #{metadata[:colors][1]}
color2 #{metadata[:colors][2]}
color3 #{metadata[:colors][3]}
color4 #{metadata[:colors][4]}
color5 #{metadata[:colors][5]}
color6 #{metadata[:colors][6]}
color7 #{metadata[:colors][7]}
color8 #{metadata[:colors][4]}
color9 #{metadata[:colors][1]}
color10 #{metadata[:colors][2]}
color11 #{metadata[:colors][3]}
color12 #{metadata[:colors][4]}
color13 #{metadata[:colors][5]}
color14 #{metadata[:colors][6]}
color15 #{metadata[:colors][7]}
")
