#!/usr/bin/env bash

ARQUIVO_DE_CONFIGURACAO="$1" # parâmetro será o nome do arquivo

# teste
[ ! -e "$ARQUIVO_DE_CONFIGURACAO" ] && echo "Erro. Arquivo não existe." && exit 1
[ ! -r "$ARQUIVO_DE_CONFIGURACAO" ] && echo "Erro. Sem acesso de leitura ao arquivo ${ARQUIVO_DE_CONFIGURACAO}" && exit 1

# execução
while read -r linha
do
  [ "$(echo $linha | cut -c 1)" = "#" ] && continue # removendo comentários no arquivo
  [ ! "$linha" ] && continue # pula linhas vazias

  chave="$(echo $linha | cut -d = -f 1)" # extrai o nome do parametro
  valor="$(echo $linha | cut -d = -f 2)" # extrai o valor do parametro

  echo "CONF_$chave=$valor"
done < "$ARQUIVO_DE_CONFIGURACAO"
