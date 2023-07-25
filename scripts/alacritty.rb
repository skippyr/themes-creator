require_relative('libraries/io')

metadata = parse_metadata()
write_theme_file(__FILE__, "colors:
  primary:
    background: #{quote(metadata[:colors][0])}
    foreground: #{quote(metadata[:colors][7])}
  cursor:
    text: CellBackground
    cursor: CellForeground
  selection:
    text: CellBackground
    cursor: CellForeground
  normal:
    black: #{quote(metadata[:colors][0])}
    red: #{quote(metadata[:colors][1])}
    green: #{quote(metadata[:colors][2])}
    yellow: #{quote(metadata[:colors][3])}
    blue: #{quote(metadata[:colors][4])}
    magenta: #{quote(metadata[:colors][5])}
    cyan: #{quote(metadata[:colors][6])}
    white: #{quote(metadata[:colors][7])}
  bright:
    black: #{quote(metadata[:colors][0])}
    red: #{quote(metadata[:colors][1])}
    green: #{quote(metadata[:colors][2])}
    yellow: #{quote(metadata[:colors][3])}
    blue: #{quote(metadata[:colors][4])}
    magenta: #{quote(metadata[:colors][5])}
    cyan: #{quote(metadata[:colors][6])}
    white: #{quote(metadata[:colors][7])}
")
