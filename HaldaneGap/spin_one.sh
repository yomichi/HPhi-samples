#!/bin/sh

hphi="../HPhi"

Ls="6 8 10 12"

output="spin_one.dat"

rm -f $output

for L in ${Ls[@]}; do
  cp StdFace.template StdFace.def
  echo "L = $L" >> StdFace.def
  echo "2S = 2" >> StdFace.def
  gap=$($hphi -S StdFace.def | awk '$1=="stp" {print $5-$4}' | tail -n 1)
  echo "$L $gap" | tee -a $output
done

gnuplot spin_one.plt
epspdf spin_one.eps

