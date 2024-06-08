#!/usr/bin/env bash
#
# task11.sh - phone book
#
# Autor:      Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Insert, delele and update phone book
#
#  Example:
#      $ source ./task11.sh
# ------------------------------------------------------------------------ #
# History:
#
#   v2.0 16/03/2024, Júlio:
#       - Add graphic interface
#   v1.0 16/03/2024, Júlio:
#       - Initial version
# ------------------------------------------------------------------------ #
# Tested in:
#   bash 5.1.16
# ------------------------------------------------------------------------ #

# variables
DATABASE_FILE="phonebook.txt"
SEP="="
TEMP=temp.$$
BLUE="\033[34;1m"
RED="\033[31;1m"

# tests
[ ! -e "$DATABASE_FILE" ] && echo "Error. File not found." && exit 1
[ ! -r "$DATABASE_FILE" ] && echo "Error. No read access file ${DATABASE_FILE}" && exit 1
[ ! -w "$DATABASE_FILE" ] && echo "Error. No write access file ${DATABASE_FILE}" && exit 1
[ ! -x "$(which dialog)" ] && sudo apt install dialog 1>/dev/null 2>&1

# functions
showPhones() {
  egrep -v "^#|^$" "$DATABASE_FILE" | tr : ' '> $TEMP
  dialog --title "Phones List" --textbox $TEMP 20 40
  rm -f "$TEMP"
}

checkPhoneExists() {
  grep -i -q "$SEP$1" "$DATABASE_FILE"
}

insertPhone() {
  local name=$(dialog --title "Phone registration" --stdout --inputbox "Insert name" 0 0)

  local phone=$(dialog --title "Phone registration" --stdout --inputbox "Insert phone" 0 0)
  checkPhoneExists "$phone" && {
    dialog --title "Fatal error!" --msgbox "Phone already exists" 6 40
    #exit 1
  }

  echo "$name$SEP$phone" >> "$DATABASE_FILE"

  sortList

  dialog --title "Success!" --msgbox "Phone added successfully!" 6 40

  showPhones
}

deletePhone(){
  local users=$(egrep "^#|^$" -v $DATABASE_FILE | sort -h | sed 's/^/"/;s/$/"/')
  local user=$(eval dialog --stdout --menu \"Choose the name:\" 0 0 0 $users)

  grep -i -v "$user" "$DATABASE_FILE" > "$TEMP"
  mv "$TEMP" "$DATABASE_FILE"

  sortList

  dialog --title "Success!" --msgbox "Phone deleted successfully!" 6 40

  showPhones
}

sortList() {
  sort "$DATABASE_FILE" > "$TEMP"
  mv "$TEMP" "$DATABASE_FILE"
}

# execução
while :
do
  action=$(dialog --title "Phone Book" \
                  --stdout \
                  --menu "Choose the options" \
                  0 0 0 \
                  list "List all phones" \
                  insert "Insert phone" \
                  delete "Delete phone")
  case $action in
    list) showPhones ;;
    insert) insertPhone ;;
    delete) deletePhone ;;
  esac
done
