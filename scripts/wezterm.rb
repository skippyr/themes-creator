require_relative("libraries/utilities")

def Create_Colors()
    Create_Colors_String(lambda {|__ansi, color_hex, __color_name| "\n    #{Quote(color_hex)},"}, true)
end

Write_Theme_File("[metadata]
name = #{Quote($metadata[:name])}
author = #{Quote($metadata[:author])}
origin_url = #{Quote($metadata[:upstream])}
[colors]
background = #{Quote($metadata[:colors_hex][0])}
foreground = #{Quote($metadata[:colors_hex][7])}
cursor_bg = #{Quote($metadata[:colors_hex][7])}
cursor_fg = #{Quote($metadata[:colors_hex][0])}
selection_bg = #{Quote($metadata[:colors_hex][7])}
selection_fg = #{Quote($metadata[:colors_hex][0])}
ansi = [" + Create_Colors() +
"\n]
brights = [" + Create_Colors() +
"\n]")
