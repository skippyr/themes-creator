require_relative("libraries/utilities")

Write_Theme_File("## name: #{$metadata[:name]}
## author: #{$metadata[:author]}
## license: #{$metadata[:license]}
## upstream: #{$metadata[:upstream]}
cursor #{$metadata[:colors_hex][7]}
cursor_text_color #{$metadata[:colors_hex][0]}
selection_background #{$metadata[:colors_hex][7]}
selection_foreground #{$metadata[:colors_hex][0]}
active_tab_background #{$metadata[:colors_hex][7]}
active_tab_foreground #{$metadata[:colors_hex][0]}
inactive_tab_background #{$metadata[:colors_hex][0]}
inactive_tab_foreground #{$metadata[:colors_hex][7]}
active_border_color #{$metadata[:colors_hex][2]}
inactive_border_color #{$metadata[:colors_hex][0]}
url_color #{$metadata[:colors_hex][4]}
background #{$metadata[:colors_hex][0]}
foreground #{$metadata[:colors_hex][7]}
" + Create_Colors_String(lambda {
    |ansi, color_hex, __color_name| "color#{ansi} #{color_hex}\n"
}))
