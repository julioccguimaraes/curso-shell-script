#!/usr/bin/env bash
#
# extrair_titulos.sh - extrai titulos do site http://lxer.com
#
# Autor:      Júlio Guimarães
# Manutenção: Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Este programa tem a intenção extrair os títulos de um site
#
#  Exemplos:
#      $ ./extrair_titulos.sh
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
VERDE="\033[32;1m"
VERMELHO="\033[31;1m"

#execução
lynx -source http://lxer.com | grep blurb | sed 's/<div.*line">//;s/<\/spa.*//' > $ARQUIVO_DE_TITULOS

while read -r titulo_lxer
do
  echo -e "${VERMELHO}Título: ${VERDE}$titulo_lxer"
done < "$ARQUIVO_DE_TITULOS"
