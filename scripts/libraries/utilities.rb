def Throw_Error(description, suggestion = "")
    STDERR.puts(
        "themes-creator: #{description}" +
        (suggestion != "" ? "\n                #{suggestion}" : "")
    )
    exit(1)
end

def Parse_Quantity_Of_Arguments()
    if (ARGV.length < 1)
        Throw_Error(
            "not enough arguments.",
            "Expected, at least, the path of metadata file."
        )
    end
end

def Treat_Colors(colors)
    treated_colors = []
    colors.each() do |color|
        if (color.length != 7 || color[0] != "#")
            Throw_Error(
                "the color \"#{color}\" is not valid.",
                "Expected to receive a HEX format."
            )
        end
        treated_colors.push(color.downcase())
    end
end

def Parse_Metadata()
    expected_number_of_lines = 12
    lines = []
    File.readlines(ARGV[0]).each do |line|
        lines.push(line.chomp())
    end
    if lines.length != expected_number_of_lines
        Throw_Error(
            "incorrect number of lines in metadata file.",
            "Expected #{expected_number_of_lines} but received #{lines.length}."
        )
    end
    $metadata = {
        name: lines[0],
        author: lines[1],
        license: lines[2],
        upstream: lines[3],
        colors: Treat_Colors(lines[4..])
    }
end

def Write_Theme_File(contents)
    scripts_directory = File.dirname(__dir__)
    if ARGV.length == 1
        puts(contents)
        return
    end
    if File.expand_path(ARGV[1]).include?(scripts_directory)
        Throw_Error("can not overwrite any scripts content.")
    end
    File.write(ARGV[1], contents)
end

Parse_Quantity_Of_Arguments()
Parse_Metadata()
