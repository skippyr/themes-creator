require_relative("libraries/utilities")

def Create_Color_Blocks(name, hex)
    blocks = ""
    suffixes = ["", "Faint", "Intense"]
    suffixes.each() do |suffix|
        blocks += "[#{name}#{suffix}]\nColor=#{hex}\n"
    end
    blocks
end

Write_Theme_File("
[General]
Description=#{$metadata[:name]}
" + Create_Color_Blocks("Background", $metadata[:colors_hex][0]) +
Create_Color_Blocks("Foreground", $metadata[:colors_hex][7]) +
Create_Colors_String(lambda {
    |ansi, color_hex, __color_name|
    Create_Color_Blocks("Color#{ansi}", color_hex)}, true
))
