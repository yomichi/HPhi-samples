f(x) = a + b*x
fit f(x) 'spin_half_ladder.dat' u (1/$1):2 via a,b

set xr [0:]
set yr [0:]
set xl "1/L"
set yl "Delta"

set size 0.7
set key off

set term postscript eps enhanced color solid
set out 'spin_half_ladder.eps'

pl f(x) lt -1, 'spin_half_ladder.dat'u (1/$1):2 w p pt 5 ps 1.5 lt 3

