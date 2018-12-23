#!/bin/bash
#
# @file init.sh
# @brief Controls script initialization
#
# @description Identifies the script has been launched or imported.
#
# @noargs
#
# @example
#   init
#
init() {
  if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
    printf "%s==>%s %s Script started in source mode:%s %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "$0" "${ALL_OFF}"
    export -f "{$0}"
  else
    printf "%s==>%s %s Script started in execute mode:%s %s\\n" "${GREEN}" "${ALL_OFF}" "${BOLD}" "$0" "${ALL_OFF}"
 $(basename "$0::main") "${@}"
  fi
  return "$?"
}
