export AltChain, altchain

type AltChain <: Model
  L :: Int
  Jz :: Float64
  Jxy :: Float64
  delta :: Float64
  z :: Tuple{Float64, Float64}
  xy :: Tuple{Complex128, Complex128}
  function AltChain(L::Integer, Jz::Real, Jxy::Real, delta::Real)
    z = (0.25Jz*(1.0+delta), 0.25Jz*(1.0-delta))
    xy = (0.5Jxy*complex(1.0+delta), 0.5Jxy*complex(1.0-delta))
    new(L, Jz, Jxy, delta, z, xy)
  end
end
altchain(L::Integer, Jz::Real, Jxy::Real, delta::Real) = AltChain(L, Jz, Jxy, delta)
altchain(L::Integer, Jz::Real; Jxy::Real = Jz, delta::Real=0.0) = AltChain(L, Jz, Jxy, delta)
num_sites(chain::AltChain) = chain.L

function interall(chain::AltChain, t::Real=0.0)
  const io = open("interall.def", "w")
  print_header(io, chain)

  ## twisted bond
  print_bond(io, 0, 1, chain.z[1], chain.xy[1]*cis(t))

  @inbounds for i in 1:(chain.L-1)
    j = (i+1)%chain.L
    parity = (i%2)+1
    print_bond(io, i, j, chain.z[parity], chain.xy[parity])
  end
  close(io)
end

function print_header(io, chain::AltChain)
println(io,
"""
=== header
NInterAll $(6chain.L)
=== reserved
=== reserved
=== end of header """)
end

