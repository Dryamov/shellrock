#!/bin/bash
#
# remove.sh
remove() {
	[[ -z "$1" ]] && printf "%s==>%s%s Missing first argument: package_name %s\\n" "${RED}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" && return 1
	local package_name="$*"
	local user_binaries
	user_binaries=$(systemd-path user-binaries)
	! [[ -d "$user_binaries" ]] && printf "%s==>%s%s Binary folder not found: %s\\n" "${RED}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" && return 1
	! [[ -f "$user_binaries/$package_name" ]] && printf "%s==>%s%s  Package not found at $user_binaries: \\n%s%s\\n" "${RED}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$package_name" && return 1
	rm "$user_binaries/$package_name" && printf "%s==>%s%s  Package succesfully uninstaled from $user_binaries: \\n%s%s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$package_name" && return 0
	return "$?"
}
