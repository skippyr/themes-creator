require_relative('../libs/utils')

write_theme_file("static const char *colorname[16] = {
#{create_color_strings(lambda {
  |_color_ansi, color_hex, _color_name|
  "\t\"#{color_hex}\","
}).join("\n")}
};
unsigned int defaultfg = 15, defaultbg = 0, defaultcs = 15;
static unsigned int defaultrcs = 0;\n")
