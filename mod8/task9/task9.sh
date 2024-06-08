#!/usr/bin/env bash
#
# task9.sh - extrai titulos do site https://tecnoblog.net
#
# Autor:      Júlio Guimarães
# Manutenção: Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Este programa tem a intenção extrair os títulos de um site
#
#  Exemplos:
#      $ ./task9.sh
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.1 16/03/2024, Júlio:
#       - Adiciona arquivo de configuração
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
ARQUIVO_DE_CONFIGURACAO="config.cf"
ARQUIVO_DE_TITULOS="titulos.txt"
USAR_CORES=
AZUL="\033[34;1m"
VERMELHO="\033[31;1m"

eval $(./parser.sh $ARQUIVO_DE_CONFIGURACAO)

[ "$(echo $CONF_USAR_CORES)" = "1" ] && USAR_CORES=1

#execução
lynx -source https://tecnoblog.net | grep "<h2>" | sed 's/<h2>//;s/<\/h2>//' > $ARQUIVO_DE_TITULOS

while read -r titulo_lxer
do
  [ "$USAR_CORES" = "1" ] && (echo -e "${VERMELHO}Título: ${AZUL}$titulo_lxer") || (echo "Título: $titulo_lxer")
done < "$ARQUIVO_DE_TITULOS"
