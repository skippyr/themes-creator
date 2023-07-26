require_relative("libraries/utilities")

Write_Theme_File("[profiles]
  [[default]]
    background_color = #{Quote($metadata[:colors_hex][0])}
    foreground_color = #{Quote($metadata[:colors_hex][7])}
    palette = #{Quote(Create_Colors_String(lambda {
        |__ansi, color_hex, __color_name| "#{color_hex}:"
    }))}
")
