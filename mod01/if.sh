#!/usr/bin/env bash
VAR=""
VAR2=""

if [[ "$VAR" = "$VAR2" ]]; then
  echo "São iguais 1."
fi

if [[ "$VAR" = "$VAR2" ]]
then
  echo "São iguais 2."
fi

if test "$VAR" = "$VAR2"; then
  echo "São iguais 3."
fi

if [ "$VAR" = "$VAR2" ]; then
  echo "São iguais 4."
fi

# forma reduzida
[ "$VAR" = "$VAR2" ] && echo "São iguais 5."
[ "$VAR" = "$VAR2" ] || echo "São iguais 5."
