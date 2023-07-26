require_relative("libraries/utilities")

Write_Theme_File("{
    #{Quote("name")}: #{Quote($metadata[:name])},
" + Create_Colors_String(lambda {
    |ansi, color_hex, color_name|
    "    #{Quote(color_name)}: #{Quote(color_hex)},\n"
}, true, false, true) + Create_Colors_String(lambda {
    |ansi, color_hex, color_name|
    "    #{Quote(
        "bright" + color_name[0].upcase() + color_name[1..]
    )}: #{Quote(color_hex)},\n"
}, true, true, true) +
"    #{Quote("background")}: #{Quote($metadata[:colors_hex][0])},
    #{Quote("foreground")}: #{Quote($metadata[:colors_hex][7])},
    #{Quote("cursorColor")}: #{Quote($metadata[:colors_hex][7])},
    #{Quote("selectionBackground")}: #{Quote($metadata[:colors_hex][7])}
}")
