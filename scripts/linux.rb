require_relative("libraries/utilities")

Write_Theme_File("#!/usr/bin/env bash
[[ ${TERM} != \"linux\" ]] && exit
" + Create_Colors_String(lambda {
    |ansi, color_hex, __color_name| "echo -en #{Quote(
        "\\\\e]P#{ansi.to_s(16)}#{color_hex[1..]}"
    )}\n"
}))

