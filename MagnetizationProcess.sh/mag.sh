#!/bin/sh

hphi="../HPhi"

#Ls="4 6 8 10"
Ls="10"
hs=`seq 0.0 0.1 10.0`

for L in ${Ls[@]}; do
  result="mag-L${L}.dat"
  stdout="hphi-${L}.out"
  stderr="hphi-${L}.err"

  rm -f $result $stdout $stderr
  for h in ${hs[@]}; do
    cp StdFace.template StdFace.def
    echo "L = $L" >> StdFace.def
    echo "h = $h" >> StdFace.def
    $hphi -s StdFace.def >> $stdout 2>> $stderr
    L=`awk '$1=="L" {print $3}' StdFace.def`
    mag=`gawk --assign L=$L '$1=="Sz" {print -$2 / L}' output/zvo_energy.dat`
    echo "$h $mag" | tee -a $result
  done
done
