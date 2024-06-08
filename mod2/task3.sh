#!/usr/bin/env bash
#
# task3.sh - boas práticas
#
# Site:       https://boaspraticas.com.br
# Autor:      Júlio Guimarães
# Manutenção: Júlio Guimarães
#
# ------------------------------------------------------------------------ #
#  Este programa tem a intenção de colocar boas práticas em prática.
#
#  Exemplos:
#      $ ./task3.sh
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 14/03/2024, Júlio:
#       - Início do programa
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16
# ------------------------------------------------------------------------ #
# Agradecimentos:
#
# 	Meu pai e minha mãe - sem eles não estaria aprendendo shell
# ------------------------------------------------------------------------ #

start=0 end=100;

[ $start -ge $end ] && exit 1

for i in $(seq $start $end);do
  for j in $(seq $i $end);do
  printf "*";done;
printf "\n";done # break line for cascade effect of print '*' symbol
