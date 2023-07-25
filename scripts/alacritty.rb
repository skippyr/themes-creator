require_relative("libraries/metadata")
require_relative("libraries/string")

def Create_Inverted_Section(name)
    "  #{name}:\n    text: CellBackground\n    cursor: CellForeground\n"
end

def Create_Colors_Section(is_normal = true)
    color_names = [
        "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"
    ]
    section = "  #{is_normal ? "normal" : "bright"}:\n    black: #{Quote(
        is_normal ? $metadata[:colors][0] : $metadata[:colors][4]
    )}\n"
    for index in 1..7
        section += "    #{color_names[index]}: #{Quote($metadata[:colors][index])}\n"
    end
    section
end

contents = "colors:
  primary:
    background: #{Quote($metadata[:colors][0])}
    foreground: #{Quote($metadata[:colors][7])}
"
contents += (
    Create_Inverted_Section("cursor") + Create_Inverted_Section("selection") +
    Create_Colors_Section() + Create_Colors_Section(false)
)

Write_Theme_File(contents)
