require_relative("libraries/utilities")

def Create_Color(ansi, index = ansi)
    "color#{ansi} #{$metadata[:colors][index]}\n"
end

contents = "## name: #{$metadata[:name]}
## author: #{$metadata[:author]}
## license: #{$metadata[:license]}
## upstream: #{$metadata[:upstream]}
cursor #{$metadata[:colors][7]}
cursor_text_color #{$metadata[:colors][0]}
selection_background #{$metadata[:colors][7]}
selection_foreground #{$metadata[:colors][0]}
active_tab_background #{$metadata[:colors][7]}
active_tab_foreground #{$metadata[:colors][0]}
inactive_tab_background #{$metadata[:colors][0]}
inactive_tab_foreground #{$metadata[:colors][7]}
active_border_color #{$metadata[:colors][2]}
inactive_border_color #{$metadata[:colors][0]}
url_color #{$metadata[:colors][4]}
background #{$metadata[:colors][0]}
foreground #{$metadata[:colors][7]}
color0 #{$metadata[:colors][0]}
color8 #{$metadata[:colors][4]}
"

for iterator in 1..7 do
    contents += Create_Color(iterator) + Create_Color(iterator + 8, iterator)
end

Write_Theme_File(contents)
