#!/usr/bin/env bash
cut -d : -f 1 /etc/group | grep "^r"
cut -d : -f 1 /etc/group | grep "t$"
cut -d : -f 1 /etc/group | grep "^r.*t$"
cut -d : -f 1 /etc/group | grep "[ed]$"
cut -d : -f 1 /etc/group | grep "[^ed]$"
cut -d : -f 1 /etc/group | grep "^.[ud]"
cut -d : -f 1 /etc/group | egrep "^.{2,4}$"
cut -d : -f 1 /etc/group | egrep "^r|^s"
