$PROGRAM_NAME = File.basename(__FILE__, File.extname(__FILE__))

def Throw_Error(description, suggestion = nil)
	prefix = "#{$PROGRAM_NAME}: "
	STDERR.puts("#{prefix}#{description}#{
		suggestion ? "\n#{" " * prefix.length}#{suggestion}" : ""
	}")
	exit(1)
end
