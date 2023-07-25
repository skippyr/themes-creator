require_relative("libraries/utilities")

Write_Theme_File(
    "static const char *colorname[16] = {" +
    Create_Colors_String(lambda {
        |ansi, color_hex, __color_name| "#{
            ansi % 7 == 0 ? "\n\t" : ", "
        }#{Quote(color_hex)}"
    }) +
    "\n};
unsigned int defaultfg = 15, defaultbg = 0, defaultcs = 15;
static unsigned int defaultrcs = 0;"
)
