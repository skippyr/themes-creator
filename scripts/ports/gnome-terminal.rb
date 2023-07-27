require_relative('../libs/utils')

write_theme_file("#!/usr/bin/env bash
profile_uuid=$(
  gsettings get org.gnome.Terminal.ProfilesList default | tr -d \\'
)
apply_property() {
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/\\
profiles:/:${profile_uuid}/ \"${1}\" \"${2}\"
}
apply_property use-theme-colors false
apply_property background-color \"#{$metadata[:colors_hex][0]}\"
apply_property foreground-color \"#{$metadata[:colors_hex][7]}\"
apply_property cursor-background-color \"#{$metadata[:colors_hex][7]}\"
apply_property cursor-foreground-color \"#{$metadata[:colors_hex][0]}\"
apply_property highlight-background-color \"#{$metadata[:colors_hex][7]}\"
apply_property highlight-foreground-color \"#{$metadata[:colors_hex][0]}\"
apply_property palette \"[
#{create_color_strings(lambda {
  |_color_ansi, color_hex, _color_name| "  \\\"#{color_hex}\\\""
}).join(",\n")}
]\"\n", is_executable: true)
