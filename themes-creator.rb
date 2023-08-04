$PROGRAM_NAME = File.basename(__FILE__, File.extname(__FILE__))
$PROGRAM_VERSION = "v2.1.2"
$PROGRAM_HELP =
  "Usage: #{$PROGRAM_NAME} <METADATA FILE> <TEMPLATE FILE>\n" +
  "Creates theme files based on templates.\n\n" +
  "METADATA FLAGS\n" +
  "The following flags allow you to get information about the program.\n\n" +
  "  --help     prints these help instructions.\n" +
  "  --version  prints its version."

def throw_error(description, suggestion = nil)
  STDERR.puts("Error Report - #{$PROGRAM_NAME} (1):")
  STDERR.puts("  Description:")
  STDERR.puts("    #{description}")
  if (suggestion)
    STDERR.puts("\n  Suggestion:")
    STDERR.puts("    #{suggestion}")
  end
  exit(1)
end

def parse_metadata_flag(flag, text)
  if (ARGV.include?("--#{flag}"))
    puts(text)
    exit(0)
  end
end

def check_file_existence(name, path)
  throw_error(
    "The #{name} file \"#{path}\" does not exists.",
    "Ensure that you did not misspelled it."
  ) unless File.exist?(path)
end

def parse_colors(colors)
  parsed_colors = []
  expected_total_characters = 7
  colors.each() do |color|
    if (color[0] != "#")
      throw_error(
        "The color \"#{color}\" must start with the \"#\" character.",
        "Ensure to use it."
      )
    elsif (color.length != expected_total_characters)
      throw_error(
        "The color \"#{color}\" contains an invalid number of characters.",
        "Expected #{expected_total_characters} but received #{color.length}."
      )
    else
      color[1..].chars().each() do |character|
        if (!character.match(/[0-9a-f]/i))
          throw_error(
            "The color \"#{color}\" contains an invalid character: " +
            "\"#{character}\".", "Ensure that you did not " +
            "misspelled it."
          )
        end
      end
    end
    parsed_colors.push(color.downcase())
  end
  parsed_colors
end

def get_metadata()
  expected_total_lines = 12
  lines = File.readlines(ARGV[0], chomp: true)
  if (lines.length != expected_total_lines)
    throw_error(
      "The metadata file \"#{ARGV[0]}\" contains an invalid number of lines.",
      "Expected #{expected_total_lines} but received #{lines.length}."
    )
  end
  return ({
    name: lines[0].strip(),
    author: lines[1].strip(),
    license: lines[2].strip(),
    url: lines[3].strip(),
    colors: parse_colors(lines[4..])
  })
end

def create_template_string(label)
  "~%{#{label}}%~"
end

def apply_template()
  metadata = get_metadata()
  template = File.read(ARGV[1])
  ["name", "author", "license", "url"].each() do |template_string|
    template.gsub!(
      create_template_string(template_string),
      metadata[template_string.to_sym()]
    )
  end
  color_index = 0
  [
    "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"
  ].each() do |color|
    template.gsub!(
      create_template_string(color),
      metadata[:colors][color_index]
    )
    color_index += 1
  end
  puts(template)
end

parse_metadata_flag("version", $PROGRAM_VERSION)
parse_metadata_flag("help", $PROGRAM_HELP)
if (ARGV.length < 2)
  throw_error(
    "Not enough arguments.",
    "Expected the paths for metadata and theme files."
  )
end
check_file_existence("metadata", ARGV[0])
check_file_existence("template", ARGV[1])
apply_template()
