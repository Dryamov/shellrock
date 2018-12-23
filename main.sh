#!/bin/bash
#
#main.sh

main() {
	set -o errexit
#	set -o nounset
	set -o pipefail
	IFS=$'\n\t'

	local parametr
	local argument
	local action

	while [ "$#" -gt 0 ]; do
		parametr="$1"
		shift
		case $parametr in
		-h | --help | help)
			$(basename "$0::usage")
			exit 0
			;;
		-d | --debug)
			set -o xtrace
			;;
		-* | --*)
			printf "Invalid parametr: %s\\n" "$parametr"
			exit 1
			;;
		*)
			if ! command -v $(basename "$0::$parametr") >/dev/null 2>&1; then
				echo "wrong command $parametr"
				exit 1
			else
				action="$parametr"
				break
			fi
			;;
		esac
	done
	$(basename "$0::$action") "$@"
	return "$?"
}
