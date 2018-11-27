#!/bin/bash
#
#download-libraries.sh
download-libraries() {
	local ssh_user=${shellrock_username:-"shellrock"}
	local ssh_host=${shellrock_hostname:-"shellrock.cf"}
	local user_shared
	user_shared=$(systemd-path user-library-private)
	local libraries=${*:-$(ls "$user_shared")}

	printf "%s==>%s %s Downloading libraries to %s %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$user_shared"
	for library in $libraries; do
		if scp -q -r "$ssh_user@$ssh_host:.local/lib/$library" "$user_shared"; then
			printf "%s ->%s %s Libraries downloaded  %s: %s\\n" "${BLUE}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$library"
		else
			printf "%s ->%s %s Library recived failed %s: %s\\n" "${RED}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$library" && return 1
		fi
	done
	printf "%s==>%s %s All libraries downloadeds %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}"
	return "$?"
}
