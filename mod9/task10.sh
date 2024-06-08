#!/usr/bin/env bash
#
# task10.sh - phone book
#
# Autor:      Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Insert, delele and update phone book
#
#  Example:
#      $ source ./task10.sh
#      $ phoneList
#      $ insertPhone julio:35999997777
#      $ deletePhone 35999997777
# ------------------------------------------------------------------------ #
# History:
#
#   v1.0 16/03/2024, Júlio:
#       - Initial version
# ------------------------------------------------------------------------ #
# Tested in:
#   bash 5.1.16
# ------------------------------------------------------------------------ #

# variables
DATABASE_FILE="phonebook.txt"
SEP="="
TEMP=temp.$$ # $$ tempo execuçao script
BLUE="\033[34;1m"
RED="\033[31;1m"

# tests
[ ! -e "$DATABASE_FILE" ] && echo "Error. File not found." && exit 1
[ ! -r "$DATABASE_FILE" ] && echo "Error. No read access file ${DATABASE_FILE}" && exit 1
[ ! -w "$DATABASE_FILE" ] && echo "Error. No write access file ${DATABASE_FILE}" && exit 1

# functions
showPhones() {
    [ "$(echo $1 | cut -c 1)" = "#" ] && continue
    [ ! "$1" ] && continue

    local name="$(echo $line | cut -d $SEP -f 1)"
    local phone="$(echo $line | cut -d $SEP -f 2)"

    echo -e "${BLUE}Name: ${RED}$name / ${BLUE}Phone: ${RED}$phone"
}

phoneList() {
  while read -r line; do
    [ "$(echo $line | cut -c 1)" = "#" ] && continue
    [ ! "$line" ] && continue
    showPhones "$line"
  done < "$DATABASE_FILE"
}

checkPhoneExists() {
  grep -i -q "$SEP$1" "$DATABASE_FILE"
}

insertPhone() {
  local phone="$(echo $1 | cut -d $SEP -f 2)"

  if checkPhoneExists "$phone"; then
    echo "Error. Phone already exists"
  else
    echo "$*" >> "$DATABASE_FILE"
    echo "Phone added successfully!"
  fi
  sortList
}

deletePhone(){
  checkPhoneExists "$1" || return

  grep -i -v "$SEP$1" "$DATABASE_FILE" > "$TEMP"
  mv "$TEMP" "$DATABASE_FILE"

  echo "Phone removed successfully!"

  sortList
}

sortList() {
  sort "$DATABASE_FILE" > "$TEMP"
  mv "$TEMP" "$DATABASE_FILE"
}
