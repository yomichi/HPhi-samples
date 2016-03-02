#!/bin/sh

hphi="../HPhi"

Ls="4 6 8 10 12"

output="spin_half_ladder.dat"

rm -f $output

for L in ${Ls[@]}; do
  cp StdFace.template StdFace.def
  echo 'lattice = "ladder"' >> StdFace.def
  echo "L = $L" >> StdFace.def
  echo "W = 2" >> StdFace.def
  echo "J0 = 1.0" >> StdFace.def
  echo "J1 = 1.0" >> StdFace.def
  echo "J1'= 0.0" >> StdFace.def
  echo "J2 = 0.0" >> StdFace.def
  echo "J2'= 0.0" >> StdFace.def
  echo "2S = 1" >> StdFace.def
  $hphi -S StdFace.def
  gap=$(tail -n 1 output/zvo_Lanczos_Step.dat | awk '{print $5-$4}')
  echo "$L $gap" | tee -a $output
done

gnuplot spin_half.plt

