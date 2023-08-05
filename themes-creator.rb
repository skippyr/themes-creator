$PROGRAM_NAME = File.basename(__FILE__, File.extname(__FILE__))
$PROGRAM_VERSION = "v2.1.2"
$PROGRAM_HELP =
	"Usage: #{$PROGRAM_NAME} <METADATA FILE> <TEMPLATE FILE>\n" +
	"Creates theme files based on templates.\n\n" +
	"METADATA FLAGS\n" +
	"The following flags allow you to get information about the program.\n\n" +
	"   --help      prints these help instructions.\n" +
	"   --version   prints its version."

def Throw_Error(description, suggestion = nil)
	STDERR.puts("Error Report - #{$PROGRAM_NAME} (1):")
	STDERR.puts("  Description:")
	STDERR.puts("    #{description}")
	if (suggestion)
		STDERR.puts("\n  Suggestion:")
		STDERR.puts("    #{suggestion}")
	end
	exit(1)
end

def Parse_Metadata_Flag(flag, text)
	if (ARGV.include?("--#{flag}"))
		puts(text)
		exit(0)
	end
end

def Check_File_Existence(name, path)
	Throw_Error(
		"The #{name} file \"#{path}\" does not exists.", "Ensure that you did " +
		"not misspelled it."
	) unless File.exist?(path)
end

def Parse_Colors(colors)
	parsed_colors = []
	expected_total_of_characters = 7
	colors.each() do |color|
		Throw_Error(
			"The color \"#{color}\" must start with the \"#\" character.",
			"Ensure to use it."
		) unless color[0] == "#"
		Throw_Error(
			"The color \"#{color}\" contains an invalid number of characters.",
			"Expected #{expected_total_of_characters} but received " +
			"#{color.length}."
		) unless color.length == expected_total_of_characters
		color[1..].chars().each() do |character|
			Throw_Error(
				"The color \"#{color}\" contains an invalid character: " +
				"\"#{character}\".", "Ensure that you did not misspelled it."
			) unless character.match(/[0-9a-f]/i)
		end
		parsed_colors.push(color.downcase())
	end
	parsed_colors
end


def Get_Metadata()
	expected_total_of_lines = 12
	lines = File.readlines(ARGV[0], chomp: true)
	Throw_Error(
		"The metadata file \"#{ARGV[0]}\" contains an invalid number of lines.",
		"Expected #{expected_total_of_lines} but received #{lines.length}."
	) unless lines.length == expected_total_of_lines
	return ({
		name: lines[0].strip(),
		authors: lines[1].strip(),
		license: lines[2].strip(),
		url: lines[3].strip(),
		colors: Parse_Colors(lines[4..])
	})
end

def Create_Template_String(label)
	return ("~%{#{label}}%~")
end

def Apply_Template()
	metadata = Get_Metadata()
	template = File.read(ARGV[1])
	["name", "authors", "license", "url"].each() do |template_string|
		template.gsub!(
			Create_Template_String(template_string),
			metadata[template_string.to_sym()]
		)
	end
	color_index = 0
	[
		"black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"
	].each() do |color|
		template.gsub!(
			Create_Template_String(color),
			metadata[:colors][color_index]
		)
		color_index += 1
	end
	puts(template)
end

Parse_Metadata_Flag("version", $PROGRAM_VERSION)
Parse_Metadata_Flag("help", $PROGRAM_HELP)
Throw_Error(
	"Not enough arguments.",
	"Expected the paths for metadata and theme files."
) unless ARGV.length >= 2
Check_File_Existence("metadata", ARGV[0])
Check_File_Existence("template", ARGV[1])
Apply_Template()
