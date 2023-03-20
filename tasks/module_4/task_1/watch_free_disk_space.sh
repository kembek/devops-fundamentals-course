#!/bin/bash

PERCENT=10

if [[ $# -le 0 ]] ; then
  printf "Using default value for threshold!\n"
elif [[ $1 =~ ^-?[0-9]+([0-9]+)?$ ]] ; then
  PERCENT=$1
fi

let "PERCENT += 0"
printf "Threshold = %d\n" $PERCENT

df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1 }' | while read data;
do
    used=$(echo $data | awk '{print $1}' | sed s/%//g)
    p=$(echo $data | awk '{print $2}')

    if [[ ! $used =~ ^[+-]?[0-9]+([.][0-9]+)?$ ]] ; then
      continue
    fi

    if [[ $used -ge $PERCENT ]] ; then
      echo "WARNING: The partition \"$p\" has used $used% of total available space - Date: $(date)"
    fi
done