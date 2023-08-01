$PROGRAM_NAME = File.basename(__FILE__, File.extname(__FILE__))

def Throw_Error(description, suggestion = nil)
	p = "#{$PROGRAM_NAME}: "
	STDERR.puts("#{p}#{description}#{
		suggestion ? "\n#{" " * p.length}#{suggestion}" : ""
	}")
	exit(1)
end

if (ARGV.length < 2)
	Throw_Error(
		"not enough arguments.", "Expects the paths for metadata and template " +
		"files."
	)
end

if (!File.exist?(ARGV[0]))
	Throw_Error(
		"the metadata file \"#{ARGV[0]}\" does not exists.", "Ensure that you " +
		"did not misspelled it."
	)
elsif (!File.exist?(ARGV[1]))
	Throw_Error(
		"the template file \"#{ARGV[1]}\" does not exists.", "Ensure that you " +
		"did not misspelled it."
	)
end

def Parse_Colors(colors)
	pclr = []
	tchr = 7
	colors.each() do |clr|
		if (clr[0] != "#")
			Throw_Error(
				"the color \"#{clr}\" must start with the \"#\" character.",
				"Ensure to use it."
			)
		elsif (clr.length != tchr)
			Throw_Error(
				"the color \"#{clr}\" contains an invalid number of characters.",
				"Expected \"#{tchr}\" but received " +
				"#{clr.length}."
			)
		else
			clr[1..].chars().each() do |c|
				if (!c.match(/[0-9a-f]/i))
					Throw_Error(
						"the color \"#{clr}\" contains an invalid character: " +
						"\"#{c}\".", "Ensure that you did not " +
						"misspelled it."
					)
				end
			end
		end
		pclr.push(clr.downcase())
	end
	return (pclr)
end

def Get_Metadata()
	etl = 12
	ln = File.readlines(ARGV[0], chomp: true)
	if (ln.length != etl)
		Throw_Error(
			"the metadata file \"#{ARGV[0]}\" contains an invalid number of " +
			"lines.", "Expected #{etl} but received " +
			"#{ln.length}."
		)
	end
	return ({
		name: ln[0].strip(),
		author: ln[1].strip(),
		license: ln[2].strip(),
		url: ln[3].strip(),
		colors: Parse_Colors(ln[4..])
	})
end

def Create_Template_String(label)
	return ("~%{#{label}}%~")
end

def Apply_Template(metadata)
	tplt = File.read(ARGV[1])
	["name", "author", "license", "url"].each() do |s|
		tplt.gsub!(Create_Template_String(s), metadata[s.to_sym()])
	end
	i = 0
	[
		"black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"
	].each() do |c|
		tplt.gsub!(
			Create_Template_String(c),
			metadata[:colors][i]
		)
		i += 1
	end
	puts(tplt)
end

metadata = Get_Metadata()
Apply_Template(metadata)
