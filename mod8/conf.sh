#!/usr/bin/env bash

# variáveis
ARQUIVO_DE_CONFIGURACAO="configuracao.cf"
USAR_CORES=
USAR_MAIUSCULAS=
MENSAGEM="Mensagem de teste"
AZUL="\033[34;1m"
VERMELHO="\033[31;1m"

# teste
[ ! -r "$ARQUIVO_DE_CONFIGURACAO" ] &&
  echo "Não temos acesso de leitura ao arquivo ${ARQUIVO_DE_CONFIGURACAO}" &&
  exit 1

# funções
DefinirParametros() {
  local parametro="$(echo $1 | cut -d = -f 1)" # extrai o nome do parametro
  local valor="$(echo $1 | cut -d = -f 2)" # extrai o valor do parametro

  case "$parametro" in
    # USAR_CORES) USAR_CORES="$valor" ;;
    # USAR_MAIUSCULAS) USAR_MAIUSCULAS="$valor" ;;
    USAR_CORES) USAR_CORES=$valor ;;
    USAR_MAIUSCULAS) USAR_MAIUSCULAS=$valor ;;
  esac
}

# execução
while read -r linha
do
  [ "$(echo $linha | cut -c1)" = "#" ] && continue # removendo comentários no arquivo
  [ ! "$linha" ] && continue # pula linhas vazias
  DefinirParametros "$linha"
done < "$ARQUIVO_DE_CONFIGURACAO"

#[ "$USAR_MAIUSCULAS" = "1" ] && MENSAGEM="$(echo $MENSAGEM | tr [a-z] [A-Z])"
#[ "$USAR_CORES" = "1" ] && MENSAGEM="$(echo -e ${AZUL}$MENSAGEM)"

[ $USAR_MAIUSCULAS = 1 ] && MENSAGEM="$(echo $MENSAGEM | tr [a-z] [A-Z])"
[ $USAR_CORES = 1 ] && MENSAGEM="$(echo -e ${AZUL}$MENSAGEM)"

echo "$MENSAGEM"
