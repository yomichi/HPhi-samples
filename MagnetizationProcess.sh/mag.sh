#!/bin/sh

hphi="../HPhi"

hs=`seq 0.0 0.25 10.0`

output="mag.dat"

rm -f $output

rm -f hphi.out hphi.err

for h in ${hs[@]}; do
  cp StdFace.template StdFace.def
  echo "h = $h" >> StdFace.def
  $hphi -s StdFace.def >> hphi.out 2>> hphi.err
  L=`awk '$1=="L" {print $3}' StdFace.def`
  mag=$( echo $(awk '$1=="Sz" {print -$2}' output/zvo_energy.dat) / $L | bc -l)
  echo "$h $mag" | tee -a $output
done

