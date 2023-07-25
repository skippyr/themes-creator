require_relative("libraries/utilities")

Write_Theme_File("! name: #{$metadata[:name]}
! author: #{$metadata[:author]}
! license: #{$metadata[:license]}
! upstream: #{$metadata[:upstream]}
.*background: #{$metadata[:colors_hex][0]}
.*foreground: #{$metadata[:colors_hex][7]}
" + Create_Colors_String(lambda {
    |ansi, color_hex, __color_name| ".*color#{ansi}: #{color_hex}\n"
}))
