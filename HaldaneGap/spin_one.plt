f(x) = a + b*x*x
fit f(x) 'spin_one.dat' u (1/$1):2 via a,b

set xr [0:]
set yr [0:]
set xl "1/L"
set yl "Delta"

set size 0.7
set key off

set term postscript eps enhanced color solid
set out 'spin_one.eps'

pl 0.41048 lt -1, f(x) lt -1, 'spin_one.dat'u (1/$1):2 w p pt 5 ps 1.5 lt 3

