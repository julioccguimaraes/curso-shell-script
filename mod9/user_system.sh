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

# functions
showUsers() {
    [ "$(echo $1 | cut -c 1)" = "#" ] && continue
    [ ! "$1" ] && continue

    local id="$(echo $line | cut -d $SEP -f 1)"
    local name="$(echo $line | cut -d $SEP -f 2)"
    local email="$(echo $line | cut -d $SEP -f 3)"

    echo -e "${BLUE}ID: ${RED}$id"
    echo -e "${BLUE}Name: ${RED}$name"
    echo -e "${BLUE}E-mail: ${RED}$email"
}

usersList() {
  while read -r line; do
    [ "$(echo $line | cut -c 1)" = "#" ] && continue
    [ ! "$line" ] && continue
    showUsers "$line"
  done < "$DATABASE_FILE"
}

checkUserExists() {
  grep -i -q "$1$SEP" "$DATABASE_FILE" # -i case insensitive, -q é quite. Para ver o resultado, digite echo $?
}

insertUser() {
  local name="$(echo $1 | cut -d $SEP -f 2)" # pegando o nome para passar na função

  if checkUserExists "$name"; then
    echo "Error. User exists"
  else
    echo "$*" >> "$DATABASE_FILE" # pega todos os parâmetros e adiciona no arquivo de dados. Se colocar só um '>' ele substitui o conteúdo todo do arquivo
    echo "User added successfully!"
  fi
  sortList
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
