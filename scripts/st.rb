require_relative('libraries/io')

metadata = parse_metadata()
write_theme_file(
  __FILE__, "static const char *colorname[16] = {\n\t" +
  "#{quote(metadata[:colors][0])}, #{quote(metadata[:colors][1])}, " +
  "#{quote(metadata[:colors][2])}, #{quote(metadata[:colors][3])}, " +
  "#{quote(metadata[:colors][4])}, #{quote(metadata[:colors][5])}, " +
  "#{quote(metadata[:colors][6])},\n\t#{quote(metadata[:colors][7])}, " +
  "#{quote(metadata[:colors][4])}, #{quote(metadata[:colors][1])}, " +
  "#{quote(metadata[:colors][2])}, #{quote(metadata[:colors][3])}, " +
  "#{quote(metadata[:colors][4])}, #{quote(metadata[:colors][5])},\n\t" +
	"#{quote(metadata[:colors][6])}, #{quote(metadata[:colors][7])}
};
unsigned int defaultfg = 15, defaultbg = 0, defaultcs = 15;
static unsigned int defaultrcs = 0;
")
