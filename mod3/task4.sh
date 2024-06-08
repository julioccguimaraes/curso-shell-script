#!/usr/bin/env bash
#
# task4.sh - conta a frequencia de uso dos comandos shell
#
# Autor:      Júlio Guimarães
# Manutenção: Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Este programa tem a intenção de exibir a frequencia de uso dos comandos shell
#
#  Exemplos:
#      $ ./task4.sh -h
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 16/03/2024, Júlio:
#       - Início do programa
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16
# ------------------------------------------------------------------------ #

# variáveis

# comando cut obtém a coluna 1 do arquivo com dados separados por espaço
COMANDOS="$(cat /home/julio/.bash_history | cut -d ' ' -f 1)"

MENSAGEM_USO="
  (basename $0) [OPÇÕES]

  -h - Menu de ajuda
  -v - Versão
  -s - Exibe os comandos ordenados
  -f - Exibe a frequência de uso de cada comando
" # $0 é o nome do programa e basename remove o ./
VERSAO="v1.0"
CHAVE_ORDENA=0
CHAVE_FREQUENCIA=0
declare -A FREQUENCIAS # array para armazenar frequencia de cada comando

# execução

while test -n "$1" # valida se há parâmetro, ou seja, não é nula
do
  case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0    ;;
    -v) echo "$VERSAO" && exit 0          ;;
    -s) CHAVE_ORDENA=1                    ;;
    -f) CHAVE_FREQUENCIA=1                ;;
     *) echo "Opção inválida, digite a opção -h" && exit 1 ;;
  esac
  shift # já validou a variável $1 e agora a variável $2 passa a ser a variavel $1. $1 < $2
done

[ $CHAVE_ORDENA -eq 1 ] &&  echo "$COMANDOS" | sort && exit 0

if [ $CHAVE_FREQUENCIA -eq 1 ]; then
  # contando a frequencia
  for comando in ${COMANDOS[@]} # percorre todos array, obtendo os índices
  do
    let FREQUENCIAS[$comando]++
  done

  # exibindo as frequencias
  for frequencia in ${!FREQUENCIAS[@]}
  do
    echo "${FREQUENCIAS[$frequencia]}: $frequencia"
  done

  exit 0
fi
