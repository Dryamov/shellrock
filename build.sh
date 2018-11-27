#!/bin/bash
#
#build.sh

build() {
	[[ -z "$1" ]] && printf "%s==>%s %s Missing first argument:%s 'package names'\\n" "${YELLOW}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" && return 1
	local user_binaries
	local user_shared
	user_binaries=$(systemd-path user-binaries)
	user_shared=$(systemd-path user-library-private)

	local package_name="$*"
	local func_names
	func_names=$(ls "$user_shared"/"$package_name")
	func_names="${func_names//.sh/}"

	local func_prefix="$package_name::"
	local initer="$package_name::init "'"$@"'
	local shebang="#!/bin/bash"
	declare -Ax exported

	! [[ -d "$user_shared/$package_name" ]] && printf "%s==>%s %s Package sources folder not found:%s %s\\n" "${YELLOW}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$user_shared/$package_name" && return 1

	printf "%s==>%s %s Building package : %s '%s'\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$package_name"
	# shellcheck disable=SC1090
	source <(cat "$user_shared"/"$package_name"/*.sh) && printf "%s ->%s %s Library directory:%s  '%s'\\n" "${BLUE}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$user_shared/$package_name"
	for func in $func_names; do
		if func_body=$(declare -f "$func" 2>/dev/null); then
			printf -v exported["$func"] "%s%s\\n" "$func_prefix" "$func_body"
			printf "%s ->%s %s Exported function: %s '%s'\\n" "${BLUE}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$func"
		fi
	done

	printf "%s\\n%s\\n%s\\n" "$shebang" "${exported[@]}" "$initer" >"$user_binaries"/"$package_name"
	chmod +x "$user_binaries/$package_name"
	printf "%s ->%s %s Package builded  : %s '%s'\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}" "$user_binaries"/"$package_name"
	return 0
}
