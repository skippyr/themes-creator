require_relative("libraries/utilities")

def Create_Colors_Section(name)
    return "  #{name}:\n" + Create_Colors_String(lambda {
        |__ansi, color_hex, color_name| "    #{color_name}: #{color_hex}\n"
    }, true)
end

Write_Theme_File("colors:
  primary:
    background: #{Quote($metadata[:colors_hex][0])}
    foreground: #{Quote($metadata[:colors_hex][7])}
  cursor:
    text: CellBackground
    cursor: CellForeground
  selection:
    text: CellBackground
    cursor: CellForeground
" + Create_Colors_Section("normal") + Create_Colors_Section("bright"))
