#!/bin/bash

array=("1" "2" "3" "4" "5")
for a in ${array}
do
  echo $a
done

s1='hello'
s2='ni'
s3='world'

echo "111" s2 "2222"


function f1() {
  echo 'hhhhh'
}

f1

a=5
b=3
c='expr $a - $b'
echo "c="$c

val=`expr 2 + 2`
echo "Total value : $val"
