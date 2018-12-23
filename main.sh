#!/bin/bash
#
#main.sh

main() {
  printf "%s==>%s%s This package under construction %s\\n" "${RED}" "${ALL_OFF}" "${BOLD}" "${ALL_OFF}"
  echo "${@}"
  echo "$*"
  return 0
}
