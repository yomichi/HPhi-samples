hs=`seq 0.0 0.25 3.0`
rm -f res.dat
for h in ${hs[@]}; do
  cp StdFace.template StdFace.def
  echo "h = $h" >> StdFace.def
  sh ../HPhi.sh -s StdFace.def
  L=`awk '$1 == "L" {print $3}' StdFace.def`
  W=`awk '$1 == "W" {print $3}' StdFace.def`
  N=`echo "$L * $W" | bc -l`
  mag=`awk -v N=$N '$1 == "Sz" {print -$2/N}' output/zvo_energy.dat`
  echo $h $mag >> res.dat
done
