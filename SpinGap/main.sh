#!/bin/sh

Ls="10 12 14 16 18"

output="res.dat"

rm -f $output

for L in ${Ls[@]}; do
  cp StdFace.common StdFace.def
  echo "L = $L" >> StdFace.def
  ../HPhi.sh -S StdFace.def
  gap=$(tail -n 1 output/zvo_Lanczos_Step.dat | awk '{print $3-$2}')
  echo "$L $gap" | tee -a $output
done

