# Themes Creator

## About

A script that creates theme files based on templates.

![](preview.png)

## Installation

### Dependencies

-	ruby
-	git

### Procedures

-	Clone this repository.

```bash
git clone --depth=1 https://github.com/skippyr/themes-creator
```

-	Access the repository's directory.

```bash
cd themes-creator
```

## Usage

Use the following table as a reference:

| Line Number | Description | Replaces |
|-|-|-|
| 1 | The theme's name. | `~%{name}%~`
| 2 | The theme's author. | `~%{author}%~`
| 3 | The theme's license. | `~%{license}%~`
| 4 | The themes's url. | `~%{url}%~`
| 5 | Color 0 (black) (background). | `~%{black}%~`
| 6 | Color 1 (red). | `~%{red}%~`
| 7 | Color 2 (green). | `~%{green}%~`
| 8 | Color 3 (yellow). | `~%{yellow}%~`
| 9 | Color 4 (blue). | `~%{blue}%~`
| 10 | Color 5 (magenta). | `~%{magenta}%~`
| 11 | Color 6 (cyan). | `~%{cyan}%~`
| 12 | Color 7 (white) (foreground). | `~%{white}%~`

Colors use ANSI convention as reference. They must use HEX format, starting with the `#` character and without opacity attributes. Their case does not matter.

### Creating A Theme From Template

-	Create a metadata file for your theme using the `metadata.template` file as a template or as an example to use with the script. The lines inside of that file follows the convention used in the reference table for the `Line Number` and `Description` columns.

-	Use the script `themes-creator.rb` using the paths for your metadata file and a template from the `templates` directory as arguments. For example: to create a theme for Xresources:

```bash
ruby themes-creator.rb metadata.template templates/xresources.template
```

### Creating A Template

You can create your own templates to use with the script. For that, you must write a theme file using the strings described in the `Replaces` column of the reference table. They will get replaced by the script by their equivalent data from metadata file. Use the `Description` column of the same table to see what they mean.

### Testing A Theme

You can preview your terminal emulator's color by running the `tests/preview.rb` script.

```bash
ruby tests/preview.rb
```

## Copyright

Copyright (c) Sherman Rofeman. MIT license.
