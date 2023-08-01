$PROGRAM_NAME = File.basename(__FILE__, File.extname(__FILE__))

def Throw_Error(description, suggestion = nil)
	prefix = "#{$PROGRAM_NAME}: "
	STDERR.puts("#{prefix}#{description}#{
		suggestion ? "\n#{" " * prefix.length}#{suggestion}" : ""
	}")
	exit(1)
end

if (ARGV.length != 2)
	Throw_Error(
		"not enough arguments.",
		"Expects the paths for metadata and template files."
	)
end

if (!File.exist?(ARGV[0]))
	Throw_Error(
		"the metadata file \"#{ARGV[0]}\" does not exists.",
		"Ensure that you did not misspelled it."
	)
elsif (!File.exist?(ARGV[1]))
	Throw_Error(
		"the template file \"#{ARGV[1]}\" does not exists.",
		"Ensure that you did not misspelled it."
	)
end

def Parse_Colors(colors)
	parsed_colors = []
	expected_total_of_characters = 7
	colors.each() do |color|
		if (color[0] != "#")
			Throw_Error(
				"the color \"#{color}\" must start with the \"#\" character.",
				"Ensure to use it."
			)
		elsif (color.length != expected_total_of_characters)
			Throw_Error(
				"the color \"#{color}\" contains an invalid number of characters.",
				"Expected \"#{expected_total_of_characters}\" but received " +
				"#{color.length}."
			)
		else
			color[1..].chars().each() do |color_character|
				if (!color_character.match(/[0-9a-f]/i))
					Throw_Error(
						"the color \"#{color}\" contains an invalid character: " +
						"\"#{color_character}\".", "Ensure that you did not " +
						"misspelled it."
					)
				end
			end
		end
		parsed_colors.push(color.downcase())
	end
	return (parsed_colors)
end

def Get_Metadata()
	expected_total_of_lines = 12
	lines = File.readlines(ARGV[0], chomp: true)
	if (lines.length != expected_total_of_lines)
		Throw_Error(
			"the metadata file \"#{ARGV[0]}\" contains an invalid number of " +
			"lines.", "Expected #{expected_total_of_lines} but received " +
			"#{lines.length}."
		)
	end
	return ({
		name: lines[0].strip(),
		author: lines[1].strip(),
		license: lines[2].strip(),
		url: lines[3].strip(),
		colors: Parse_Colors(lines[4..])
	})
end

metadata = Get_Metadata()
puts(metadata)
