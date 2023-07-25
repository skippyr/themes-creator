def throw_error(error_message)
  STDERR.puts("themes-creator: #{error_message}")
  exit(1)
end

if (ARGV.length < 1) then
  throw_error('not enough arguments.')
end

def parse_metadata()
  expected_number_of_lines = 9
  lines = []
  File.readlines(ARGV[0]).each do |line| lines.push(line.chomp()) end
  if (lines.length != expected_number_of_lines)
    throw_error(
      "incorrect number of lines in metadata file.\n                Expected " +
      "#{expected_number_of_lines} but received #{lines.length}."
    )
  end
  metadata = {
    name: lines[0],
    colors: lines[1..9]
  }
  return metadata
end

def write_theme_file(script_file, contents)
  if (ARGV.length < 2) then
    puts(contents)
  else
    out_file = File.expand_path(ARGV[1])
    if (out_file == File.expand_path(script_file))
      throw_error("can not override script \"#{script_file}\".")
    else
      File.write(ARGV[1], contents)
    end
  end
end
