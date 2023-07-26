require_relative("libraries/utilities")

Write_Theme_File("#!/usr/bin/env bash

Write_Property() {
    profile_uuid=$(
        gsettings get org.gnome.Terminal.ProfilesList default | tr -d \\'
    )
    gsettings\\
        set #{Quote(
            "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/" +
            "\\\nprofiles:/:${profile_uuid}/"
        )} #{Quote("${1}")} #{Quote("${2}")}
}

Write_Property use-theme-colors false
Write_Property background-color #{Quote($metadata[:colors_hex][0])}
Write_Property foreground-color #{Quote($metadata[:colors_hex][7])}
Write_Property cursor-background-color #{Quote($metadata[:colors_hex][7])}
Write_Property cursor-foreground-color #{Quote($metadata[:colors_hex][0])}
Write_Property highlight-background-color #{Quote($metadata[:colors_hex][7])}
Write_Property highlight-foreground-color #{Quote($metadata[:colors_hex][0])}
Write_Property palette\\
    #{Quote("[" + Create_Colors_String(
        lambda {|ansi, color_hex, __color_name|
"\\\"#{color_hex}\\\"#{ansi == 7 ? "" : ","}#{ansi == 5 ? "\n" : ""}"}, true
) + "]")}
", true)
