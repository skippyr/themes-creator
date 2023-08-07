$PROGRAM_NAME = File.basename(__FILE__, File.extname(__FILE__))
$PROGRAM_VERSION = "v2.1.2"

def
Throw_Error(description, suggestion = nil)
    prefix = "#{$PROGRAM_NAME}: "
    STDERR.puts("#{prefix}#{description}")
    STDERR.puts("#{" " * prefix.length}#{suggestion}") if (suggestion)
    exit(1)
end

def
Parse_Metadata_Flag(flag, action)
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
Check_File_Existence(name, path)
    suggestion = "Ensure that you did not misspelled it."
    prefix = "The #{name} file \"#{path}\" "
    Throw_Error("#{prefix}does not exists.",
                suggestion) if (!File.exist?(path))
    Throw_Error("#{prefix}is not a file.", suggestion) if (!File.file?(path))
end

Parse_Metadata_Flag("help", lambda{Print_Help()})
Parse_Metadata_Flag("version", lambda{puts($PROGRAM_VERSION)})

Throw_Error("not enough arguments.", "Expected the paths for metadata and " +
            "template files.") if ARGV.length < 2

Check_File_Existence("metadata", ARGV[0])
Check_File_Existence("template", ARGV[1])
