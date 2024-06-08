#!/usr/bin/env bash

# variáveis
ARQUIVO_DE_CONFIGURACAO="configuracao.cf"
USAR_CORES=
USAR_MAIUSCULAS=
MENSAGEM="Mensagem de teste"
AZUL="\033[34;1m"
VERMELHO="\033[31;1m"

# eval permite obter os dados do echo dentro do parser.sh, ou seja criar as variáveis dentro do ambiente
eval $(./parser.sh $ARQUIVO_DE_CONFIGURACAO)

[ "$(echo $CONF_USAR_MAIUSCULAS)" = "1" ] && USAR_MAIUSCULAS=1
[ "$(echo $CONF_USAR_CORES)" = "1" ] && USAR_CORES=1

[ "$USAR_MAIUSCULAS" = "1" ] && MENSAGEM="$(echo $MENSAGEM | tr a-z A-Z)"
[ "$USAR_CORES" = "1" ] && MENSAGEM="$(echo -e ${AZUL}$MENSAGEM)"

echo "$MENSAGEM"
