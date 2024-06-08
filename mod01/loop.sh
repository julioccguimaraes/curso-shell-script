#!/usr/bin/env bash
echo "---- for 1, menos comum"
for (( i = 0; i < 10; i++ )); do
  echo "$i"
done

echo "for 2, mais comum (seq é comando nativo shell)"
for i in $(seq 10); do
  echo "$i"
done

echo "---- for 3, array"

Frutas=('Laranja' 'Ameixa' 'Abacaxi')
for i in "${Frutas[@]}"; do #@ indica que está passando todos os itens. Recomenda-se colocar aspas pois os itens é string
  echo "$i"
done

echo "---- while"
contador=0
while [[ $contador -lt ${#Frutas[@]} ]]; do # '#' pega o tamanho do array
  echo ${Frutas[$contador]}
  contador=$(($contador+1))
done
