#!/bin/bash
#
#upload-libraries.sh

upload-libraries() {
	local user_shared
	user_shared=$(systemd-path user-library-private)
	local user_binaries
	user_binaries=$(systemd-path user-binaries)
	local packages=${*:-$(ls "$user_binaries")}
	local sources=${*:-$(ls "$user_shared")}
	local ssh_user=${shellrock_username:-"shellrock"}
	local ssh_host=${shellrock_hostname:-"shellrock.cf"}

	for source in $sources; do
		scp -r -q "$user_shared/$source" "$ssh_user"@"$ssh_host":.local/lib/ >/dev/null && printf "%s==>%s %s Succesfully upload library:%s %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$source"
	done

	return "$?"
}
