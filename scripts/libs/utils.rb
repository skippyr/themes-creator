def throw_error(description, suggestion)
  program_name = 'themes-creator'
  STDERR.puts(
    "#{program_name}: #{description}\n" + ' ' * (program_name.length + 2) +
    suggestion
  )
  exit(1)
end

def check_arguments()
  scripts_directory = File.dirname(__dir__)
  if (ARGV.length == 0)
    throw_error(
      'not enought arguments',
      'Expected, at least, the path for your metadata file.'
    )
  elsif (ARGV.length > 1)
    if (!File.exist?(File.dirname(ARGV[1])))
      throw_error(
        "the parent directory of the theme file \"#{ARGV[1]}\" does not exists.",
        'Ensure to create it first.'
      )
    elsif (File.expand_path(ARGV[1]).include?(scripts_directory))
      throw_error(
        "the theme file \"#{ARGV[1]}\" can not be inside of the scripts " +
        'directory.', 'Try using another directory.'
      )
    end
  end
  if (!File.exist?(ARGV[0]))
    throw_error(
      "the metadata file \"#{ARGV[0]}\" does not exists.",
      'Ensure that you did not misspelled its path.'
    )
  end
end

def parse_colors(colors_hex)
  treated_colors_hex = []
  colors_hex.each() do |color_hex|
    if (color_hex.length != 7)
      throw_error(
        "the HEX color \"#{color_hex}\" has an invalid number of characters.",
        'Ensure that you did not misspelled.'
      )
    elsif (color_hex[0] != '#')
      throw_error(
        "the HEX color \"#{color_hex}\" must start with the \"#\" character.",
        'Ensure that you did not misspelled.'
      )
    end
    color_hex.chars()[1..].each() do |character|
      if (!character.match(/[0-9A-Fa-f]/))
        throw_error(
          "the HEX color \"#{color_hex}\" contains an invalid character: " +
          "\"#{character}\".", 'Ensure that you did not mispelled it.'
        )
      end
    end
    treated_colors_hex.push(color_hex.downcase())
  end
  treated_colors_hex
end

def parse_metadata()
  expected_number_of_lines = 12
  lines = File.readlines(ARGV[0], chomp: true)
  if (lines.length != expected_number_of_lines)
    throw_error(
      "the metadata file \"#{ARGV[0]}\" contains an invalid number of lines.",
      "Expected #{expected_number_of_lines} but received #{lines.length}."
    )
  end
  $metadata = {
    name: lines[0],
    author: lines[1],
    license: lines[2],
    upstream: lines[3],
    colors_hex: parse_colors(lines[4..])
  }
end

def write_theme_file(contents)
  if (ARGV[1])
    File.write(ARGV[1], contents)
  else
    print(contents)
  end
end

def create_color_strings(
  filter, use_groups: false, is_bright_group: false,
  use_bright_names: false, use_purple: false
)
  color_names = [
    "black", "red", "green", "yellow", "blue", use_purple ?  "purple" :
    "magenta", "cyan", "white"
  ]
  color_strings = []
  for color_ansi in (
    (use_groups && is_bright_group ? 8 : 0) ..
    (use_groups && !is_bright_group ? 7 : 15)
  )
    color_hex = $metadata[:colors_hex][
      color_ansi <= 7 ? color_ansi : color_ansi == 8 ? 4 : color_ansi - 8
    ]
    color_name = color_names[color_ansi <= 7 ? color_ansi : color_ansi - 8]
    if use_bright_names && color_ansi > 7
      color_name = "bright#{color_name[0].upcase()}#{color_name[1..]}"
    end
    color_strings.push(filter.call(color_ansi, color_hex, color_name))
  end
  color_strings
end

def enclose_by_double_quotes(text, escape: false)
  quotes = "#{escape ? "\\" : ""}\""
  "#{quotes}#{text}#{quotes}"
end

check_arguments()
parse_metadata()
