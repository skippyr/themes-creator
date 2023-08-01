def Create_Colors(action)
	for color_ansi in 0..15
		print(action.call(color_ansi))
	end
	puts()
end

Create_Colors(lambda {|color_ansi| "#{"%3s" % color_ansi}"})
Create_Colors(lambda {|color_ansi| "\x1b[48;5;#{color_ansi}m   \x1b[0m"})
Create_Colors(lambda {|color_ansi| "\x1b[38;5;#{color_ansi}m#{
	color_ansi % 2 == 0 ? "gon" : "dra"
}\x1b[0m"})
