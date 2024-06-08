#!/usr/bin/env bash
#
# user_system.sh - user management system
#
# Autor:      Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Insert, delele and update functions to user management system
#
#  Example:
#      $ ./user_system.sh
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
DATABASE_FILE="database.txt"
SEP=":"
TEMP=temp.$$ # $$ tempo execuçao script
BLUE="\033[34;1m"
RED="\033[31;1m"

# tests
[ ! -e "$DATABASE_FILE" ] && echo "Error. File not found." && exit 1
[ ! -r "$DATABASE_FILE" ] && echo "Error. No read access file ${DATABASE_FILE}" && exit 1
[ ! -w "$DATABASE_FILE" ] && echo "Error. No write access file ${DATABASE_FILE}" && exit 1
[ ! -x "$(which dialog)" ] && sudo apt install dialog 1>/dev/null 2>&1 #redireciona saída para nenhum lugar.

# functions
usersList() {
  egrep -v "^#|^$" "$DATABASE_FILE" | tr : ' '> $TEMP # toda linha que não começa com # ou que é vazia. ts troca : por espaço
  dialog --title "Users List" --textbox $TEMP 20 40
  rm -f "$TEMP"
}

checkUserExists() {
  grep -i -q "$1$SEP" "$DATABASE_FILE" # -i case insensitive, -q é quite. Para ver o resultado, digite echo $?
}

insertUser() {
  # pega o id da última linha. Tail pega ultima linha e cut pega a primeira coluna separada por :
  local last_id="$(egrep -v "^#|^$" "$DATABASE_FILE" | sort | tail -n 1 | cut -d "$SEP" -f 1)"
  local next_id=$(( last_id+1 ))
  local name=$(dialog --title "User registration" --stdout --inputbox "Insert your name" 0 0)
  checkUserExists "$name" && {
    dialog --title "Fatal error!" --msgbox "User already exists" 6 40
    #exit 1
  }

  local email=$(dialog --title "User registration" --stdout --inputbox "Insert your email" 0 0)

  echo "$next_id$SEP$name$SEP$email" >> "$DATABASE_FILE"

  dialog --title "Success!" --msgbox "user added successfully!" 6 40
}

deleteUser(){
  checkUserExists "$1" || return # return semelhante ao exit 1. sai se usuário não existe

  grep -i -v "$1$SEP" "$DATABASE_FILE" > "$TEMP" # -v faz o grep trazer tudo menos o que está sendo passado
  mv "$TEMP" "$DATABASE_FILE"

  echo "User removed successfully!"

  sortList
}

sortList() {
  sort "$DATABASE_FILE" > "$TEMP"
  mv "$TEMP" "$DATABASE_FILE"
}
