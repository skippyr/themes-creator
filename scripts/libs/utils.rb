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
    end
    color_hex.chars()[1..].each() do |character|
      if (character.match(/[0-9A-Fa-f]/) == nil)
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

check_arguments()
parse_metadata()
puts(ARGV)
