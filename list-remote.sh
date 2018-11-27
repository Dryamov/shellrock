#!/bin/bash
#
# list-remote.sh
list-remote() {
	local ssh_user=${shellrock_username:-"shellrock"}
	local ssh_host=${shellrock_hostname:-"shellrock.cf"}
	local package_list
	local user_binaries

	if package_list=$(ssh "$ssh_user"@"$ssh_host" ls .local/bin); then
		printf "%s==>%s%s List availeble packages at %s: %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "$ssh_host" "${ALL_OFF}"
		printf "%s\\n" "$package_list"
	else
		printf "%s==>%s %s Something gonna wrong: %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}"
	fi
	return "$?"
}
