#!/bin/sh

hphi="../HPhi"

Ls="6 8 10 12"

output="spin_one_chain.dat"

rm -f $output

for L in ${Ls[@]}; do
  cp StdFace.template StdFace.def
  echo 'lattice = "chain lattice"' >> StdFace.def
  echo "L = $L" >> StdFace.def
  echo "2S = 2" >> StdFace.def
  $hphi -S StdFace.def
  gap=$(tail -n 1 output/zvo_Lanczos_Step.dat | awk '{print $5-$4}')
  echo "$L $gap" | tee -a $output
done

gnuplot spin_one_chain.plt
