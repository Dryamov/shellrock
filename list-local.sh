#!/bin/bash
#
# list-local.sh
list-local() {
	local user_binaries
	user_binaries=$(systemd-path user-binaries)
	[[ -d "$user_binaries" ]] && printf "%s==>%s%s Installed packages at $user_binaries: \\n%s%s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$(ls "$user_binaries")" && return 0
	! [[ -d "$user_binaries" ]] && printf "%s==>%s%s Binary folder not found: %s\\n" "${YELLOW}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" && return 0
	return "$?"
}
