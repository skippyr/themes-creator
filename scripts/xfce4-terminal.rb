require_relative("libraries/utilities")

Write_Theme_File("[Scheme]
Name=#{$metadata[:name]}
ColorBackground=#{$metadata[:colors_hex][0]}
ColorForeground=#{$metadata[:colors_hex][7]}
ColorPalette=" + Create_Colors_String(lambda {
    |__ansi, color_hex, __color_name| "#{color_hex};"
}) + "\n")
