#!/usr/bin/env bash
#
# chaves_flags.sh - ordena lista de usuários linux
#
# Site:       https://boaspraticas.com.br
# Autor:      Júlio Guimarães
# Manutenção: Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Este programa tem a intenção de colocar boas práticas em prática.
#
#  Exemplos:
#      $ ./chaves_flags.sh -s
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.4 16/03/2024, Júlio:
#       - Combinações de flags
#   v1.3 14/03/2024, Júlio:
#       - Flags com while, combinando opções
#   v1.2 14/03/2024, Júlio:
#       - Adicionando flags
#   v1.1 14/03/2024, Júlio:
#       - Refatora if para case
#   v1.0 14/03/2024, Júlio:
#       - Início do programa
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16
# ------------------------------------------------------------------------ #

# variáveis
USUARIOS="$(cat /etc/passwd | cut -d : -f 1)" # comando cut obtém a coluna 1 do arquivo com dados separados por :
#echo "$USUARIOS"
MENSAGEM_USO="
  (basename $0) [OPÇÕES]

  -h - Menu de ajuda
  -v - Versão
  -s - Ordenar a saída
  -m - Coloca em maiúsculo
" # $0 é o nome do programa e basename remove o ./
VERSAO="v1.3"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0

#execução
#if [ "$1" = "-h" ]; then
#  echo "$MENSAGEM_USO" && exit 0
#fi

#if [ "$1" = "-v" ]; then
#  echo "$VERSAO" && exit 0
#fi

#if [ "$1" = "-s" ]; then
#  echo "$USUARIOS" | sort && exit 0 # comando sort é nativo shell
#fi
while test -n "$1" # valida se a variável é nula, ou seja, se não for, entra no loop
do
  case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0    ;;
    -v) echo "$VERSAO" && exit 0          ;;
    -s) CHAVE_ORDENA=1                    ;;
    -m) CHAVE_MAIUSCULO=1                 ;;
     *) echo "Opção inválida, digite a opção -h" && exit 1 ;;
  esac
  shift # já validou a variável $1 e agora a variável $2 passa a ser a variavel $1 $1 < $2
done

[ $CHAVE_ORDENA -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | sort)
[ $CHAVE_MAIUSCULO -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])

echo "$USUARIOS"
