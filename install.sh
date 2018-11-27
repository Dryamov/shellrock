#!/bin/bash
#
# install.sh
install() {
	[[ -z "$1" ]] && printf "%s==>%s %s Missing first argument:%s 'packages'\\n" "${RED}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" && return 1
	local user_binaries
	user_binaries=$(systemd-path user-binaries)
	! [[ -d "$user_binaries" ]] && printf "%s==>%s %s Install directory does not exits:%s %s\\n" "${RED}" "${ALL_OFF}" "${BOLD}" "$user_binaries" "${ALL_OFF}" && return 1
	local packages=$1
	local ssh_user=${shellrock_username:-"shellrock"}
	local ssh_host=${shellrock_hostname:-"shellrock.cf"}

	for package in $packages; do

		if ! scp "$ssh_user@$ssh_host:.local/bin/$package" "$user_binaries" >/dev/null 2>error.log; then
			printf "%s==>%s %s Install package failed: %s %s %s\\n" "${RED}" "${ALL_OFF}" "${BOLD}" "$package" "${ALL_OFF}" "${BOLD}""'$(cat error.log)'""${ALL_OFF}" && return 1
		else
			chmod +x "$user_binaries/$package"
			printf "%s==>%s %s Install package sucsesful: '%s' %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "$package" "${ALL_OFF}"
		fi
	done
	return 0
}
