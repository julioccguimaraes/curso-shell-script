#!/usr/bin/env bash
CHAVE_DEBUG=0
NIVEL_DEBUG=0
ROXO="\033[35;1m"
CIANO="\033[36;1m"

Debugar() {
  [ $1 -le $NIVEL_DEBUG ] && echo -e "${2}Debug $* -----" # recebe o parâmetro 2 (cor)
}

Soma() {
  local total=0 # variável local

  for i in $(seq 1 25); do
    Debugar 1 "${ROXO}" "Entrei no for com valor: $i" # parâmetro 2 é a cor
    total=$(($total+$i))
    Debugar 2 "${CIANO}" "Depois da soma: $total"
  done

  echo $total
}

case "$1" in
  -d) [ $2 ] && NIVEL_DEBUG=$2 ;;
  *) Soma ;;
esac

Soma

# ./debug.sh -d, só vai executar sem debug
# ./debug.sh -d 1, vai passar 1 para Debugar e [1 -le 1] vai imprimir a 13 linha.
# ./debug.sh -d 2, vai passar 1 e 2 para Debugar e [1 -le 2] e [2 -le 2] vai imprimir a 13 e 15 linhas
