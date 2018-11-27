#!/bin/bash
#
#upload-packages.sh

upload-packages() {
	local user_shared
	user_shared=$(systemd-path user-library-private)
	local user_binaries
	user_binaries=$(systemd-path user-binaries)
	local packages=${*:-$(ls "$user_binaries")}
	local sources=${*:-$(ls "$user_shared")}
	local ssh_user=${shellrock_username:-"shellrock"}
	local ssh_host=${shellrock_hostname:-"shellrock.cf"}

	for package in $packages; do
		scp -r -q "$user_binaries/$package" "$ssh_user"@"$ssh_host":.local/bin/ && printf "%s==>%s %s Succesfully upload package:%s %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$package"
	done
	return "$?"
}
