#!/usr/bin/env bash

packages_list_file="dnf_installed_packages.txt"
app_version='0.1.0'
app_name='clean_packages_list'
app_help="Usage: $app_name [OPTIONS]...

$app_name removes the release number, the version number, the O.S. version number, and the architecture name from the packages names in the list in the file provided as argument or the default file if no [FILE] argument is specified; in brief it just keeps the packages name

Options:
  [FILE]              The packages names list file to clean; default file is dnf_installed_packages.txt
  v, -v, --version    Print app versiona and exit
  h, -h, --help       Print this help message and exit"

function do_cleansing {
    cp "$packages_list_file" "tmp_packages_list_file.txt"
    awk -F":" '{ sub(/-[0-9]+$/, "", $1); print $1 }' "tmp_packages_list_file.txt" > "$packages_list_file"
    rm "tmp_packages_list_file.txt"
}

if [[ "$#" -eq 1 ]]; then
	if [[ -f "$1" ]]; then
        packages_list_file="$1"
	elif [[ "$1" = "h" || "$1" = "-h" || "$1" = "--help" ]]; then
		printf "%s\n" "$app_help"
		exit 0
	elif [[ "$1" = "v" || "$1" = "-v" || "$1" = "--version" ]]; then
		printf "\033[94mVersion:\033[0m %s\n" "$app_version"
		exit 0
	else
		echo "" > /dev/null
	fi
fi

do_cleansing
printf "Done!\n"

exit 0
