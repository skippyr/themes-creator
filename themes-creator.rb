#!/usr/bin/env ruby

$PROGRAM_NAME = File.basename(__FILE__, File.extname(__FILE__))
$PROGRAM_VERSION = "v2.1.2"
$METADATA_FILE = ARGV[0]
$TEMPLATE_FILE = ARGV[1]

def
Throw_Error(description, suggestion = nil)
    prefix = "#{$PROGRAM_NAME}: "
    STDERR.puts("#{prefix}#{description}")
    STDERR.puts("#{" " * prefix.length}#{suggestion}") if (suggestion)
    exit(1)
end

def
Parse_Flag(flag, action)
    if (ARGV.include?("--#{flag}"))
        action.call()
        exit(0)
    end
end

def
Print_Help()
    puts("Usage: ruby #{$PROGRAM_NAME} <METADATA FILE> <TEMPLATE FILE>")
    puts("Creates themes based on templates.")
    puts()
    puts("METADATA FLAGS")
    puts("The following flags can be used to get information about the " +
         "program.")
    puts()
    puts("    --version    print its version.")
    puts("    --help       print these help instructions.")
    puts()
    puts("TEST FLAGS")
    puts("The following flags can be used to test themes.")
    puts()
    puts("    --preview    print the terminal emulator's colors.")
    puts()
    puts("EXIT CODES")
    puts("The exit code 1 will be throw if an error happens.")
end

def
Print_Colors()
    for ansi in 0..15
        print(yield (ansi))
    end
    puts()
end

def
Print_Preview()
    Print_Colors() {|ansi| "#{"%3s" % ansi}"}
    Print_Colors() {|ansi| "\x1b[48;5;#{ansi}m   \x1b[0m"}
    Print_Colors() {|ansi| "\x1b[38;5;#{ansi}m#{
        ansi % 2 == 0 ? "gon" : "dra"
    }\x1b[0m"}
end

def
Check_File_Existence(name, path)
    suggestion = "Ensure that you did not misspelled it."
    prefix = "The #{name} file \"#{path}\" "
    Throw_Error("#{prefix}does not exists.", suggestion) if (!File.exist?(path))
    Throw_Error("#{prefix}is not a file.", suggestion) if (!File.file?(path))
end

def
Is_Hex_Character(character)
    character.match(/[0-9a-f]/i)
end

def
Parse_Colors(colors)
    parsed_colors = []
    expected_number_of_characters = 7
    colors.each() do |color|
        prefix = "The color \"#{color}\" "
        Throw_Error("#{prefix}must start with the \"#\" character.",
                    "Ensure to use it.") if (color[0] != "#")
        Throw_Error("#{prefix}contains an invalid number of characters.",
                    "Expected #{expected_number_of_characters} but " +
                    "received #{color.length}.") if (
                        color.length != expected_number_of_characters)
        color[1..].chars().each() do |character|
            Throw_Error("#{prefix}contains an invalid character: " +
                        "\"#{character}\".", "Ensure that you did not " +
                        "misspelled it.") if !Is_Hex_Character(character)
        end
        parsed_colors.push(color.downcase())
    end
    parsed_colors
end

def
Get_Metadata()
    expected_number_of_lines = 12
    lines = File.readlines($METADATA_FILE, chomp: true)
    Throw_Error("The metadata file contains an invalid number of lines.",
                "Expected #{expected_number_of_lines} but received " +
                "#{lines.length}.") if (lines.length !=
                                        expected_number_of_lines)
    {
        name: lines[0].strip(),
        author: lines[1].strip(),
        license: lines[2].strip(),
        url: lines[3].strip(),
        colors: Parse_Colors(lines[4..])
    }
end

def
Create_Placeholder(label)
    "~%{#{label}}%~"
end

def
Apply_Template()
    metadata = Get_Metadata()
    template = File.read($TEMPLATE_FILE)
    ["name", "author", "license", "url"].each() do |label|
        template.gsub!(Create_Placeholder(label), metadata[label.to_sym()])
    end
    color_index = 0
    ["black", "red", "green", "yellow", "blue", "magenta", "cyan",
     "white"].each() do |color|
        template.gsub!(Create_Placeholder(color),
                       metadata[:colors][color_index])
        color_index += 1
    end
    puts(template)
end

Parse_Flag("help", lambda {Print_Help()})
Parse_Flag("version", lambda {puts($PROGRAM_VERSION)})
Parse_Flag("preview", lambda {Print_Preview()})

Throw_Error("not enough arguments.", "Expected the paths for metadata and " +
            "template files.") if ARGV.length < 2

Check_File_Existence("metadata", $METADATA_FILE)
Check_File_Existence("template", $TEMPLATE_FILE)

Apply_Template()
