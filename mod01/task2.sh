#!/usr/bin/env bash
for (( i = 0; i < 10; i++ )); do
  result=$(( $i % 2 ))
  [ $result = 0 ] && echo "$i é divisível por 2"
done
