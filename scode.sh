#!/bin/bash

file=$1
# get everything up until the extension
n_out=$(echo $file | grep -o "^[^\.]*")
# assembly and link
nasm -f elf64 -o ${n_out}.o $file
ld ${n_out}.o -o $n_out

count=0
for b in $(objdump -d ${n_out}.o | grep -E "[0-9a-f]+:" | cut -f2)
do
  printf "\\\\x$b"
  ((count+=1))
done

echo
echo "Shellcode length: $count bytes"
