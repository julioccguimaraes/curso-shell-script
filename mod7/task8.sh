#!/usr/bin/env bash
#
# task8.sh - extrai titulos do site https://tecnoblog.net
#
# Autor:      Júlio Guimarães
# Manutenção: Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Este programa tem a intenção extrair os títulos de um site
#
#  Exemplos:
#      $ ./task8.sh
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 16/03/2024, Júlio:
#       - Início do programa
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16
# ------------------------------------------------------------------------ #

#testes
# validando instalação do lynx
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y

# variáveis
ARQUIVO_DE_TITULOS="titulos.txt"
AZUL="\033[34;1m"
VERMELHO="\033[31;1m"

#execução
lynx -source https://tecnoblog.net | grep "<h2>" | sed 's/<h2>//;s/<\/h2>//' > $ARQUIVO_DE_TITULOS

while read -r titulo_lxer
do
  echo -e "${VERMELHO}Título: ${AZUL}$titulo_lxer"
done < "$ARQUIVO_DE_TITULOS"
