#!/usr/bin/env bash

NOME="Júlio"
echo $NOME


NOME2="Júlio
Guimarães"
echo "$NOME2" #quando se coloca a variável entre aspas, mantém a formatação

NUMERO_1=24
NUMERO_2=45

TOTAL=$(($NUMERO_1+$NUMERO_2)) # 2 parenteses caso de operações
echo "$TOTAL"

SAIDA_CAT=$(cat /etc/passwd | grep julio)
echo "$SAIDA_CAT"

# variáveis reservadas

#parâmetros
echo "Parâmetro: $1" #./variable.sh ola
echo "Parâmetro: $2" #./variable.sh ola julio
echo "Todos os parâmetros: $*" #./variable.sh ola julio cesar
echo "Quantos parâmetros: $#"
echo "Saída do último comando: $?" #0, OK - 1, erro, ou depende do programa
echo "PID $$" #PID do comando
echo "$0" #nome do script
