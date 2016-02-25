function interall(L::Integer, Jz::Real; t::Real=0.0, delta::Real=0.0, Jxy::Real=Jz)
  InterAll(L,Jz,t=t,delta=delta,Jxy=Jxy)
end

function InterAll(L::Integer, Jz::Real; t::Real=0.0, delta::Real=0.0, Jxy::Real=Jz)
  const io = open("interall.def", "w")
  print_header(io, L)
  z = 0.25Jz*[1.0+delta, 1.0-delta]
  xy = 0.5Jxy*Complex128[1.0+delta, 1.0-delta]

  ## twisted bond
  print_bond(io, 0, 1, z[1], xy[1]*cis(t))

  @inbounds for i in 1:(L-1)
    j = (i+1)%L
    parity = (i%2)+1
    print_bond(io, i, j, z[parity], xy[parity])
  end
  close(io)
end

function print_header(io, L)
println(io,
"""
=== header
NInterAll $(6L)
=== reserved
=== reserved
=== end of header """)
end

function print_bond(io, i, j, z, xy)
  ## diagonal
  @printf(io, "%d 0 %d 0 %d 0 %d 0 %lg 0.0 \n", i,i,j,j, z)
  @printf(io, "%d 1 %d 1 %d 1 %d 1 %lg 0.0 \n", i,i,j,j, z)
  @printf(io, "%d 0 %d 0 %d 1 %d 1 %lg 0.0 \n", i,i,j,j, -z)
  @printf(io, "%d 1 %d 1 %d 0 %d 0 %lg 0.0 \n", i,i,j,j, -z)

  ## offdiagonal
  @printf(io, "%d 0 %d 1 %d 1 %d 0 %lg %lg \n", i,i,j,j, xy.re, xy.im)
  @printf(io, "%d 1 %d 0 %d 0 %d 1 %lg %lg \n", i,i,j,j, xy.re, -xy.im)
end
