export AltChain, altchain

type AltChain <: Model
  S2 :: Int
  L :: Int
  Jz :: Float64
  Jxy :: Float64
  delta :: Float64
  z :: Tuple{Float64, Float64}
  xy :: Tuple{Complex128, Complex128}
  coeff :: BondCoeffs
  function AltChain(S2::Integer, L::Integer, Jz::Real, Jxy::Real, delta::Real)
    c = bond_coeffs(S2)
    z = (Jz*(1.0+delta), Jz*(1.0-delta))
    xy = (Jxy*(1.0+delta), Jxy*(1.0-delta))
    new(S2, L, Jz, Jxy, delta, z, xy, c)
  end
end
altchain(S2::Integer, L::Integer, Jz::Real, Jxy::Real, delta::Real) = AltChain(S2, L, Jz, Jxy, delta)
altchain(S2::Integer, L::Integer, Jz::Real; Jxy::Real = Jz, delta::Real=0.0) = AltChain(S2, L, Jz, Jxy, delta)
num_sites(chain::AltChain) = chain.L
num_bonds(chain::AltChain) = chain.L

function interall(chain::AltChain, t::Real=0.0)
  const io = open("interall.def", "w")
  header_interall(io, chain)

  ## twisted bond
  bond(io, 0, 1, chain.z[1], chain.xy[1]*cis(t), chain.coeff)

  @inbounds for i in 1:(chain.L-1)
    j = (i+1)%chain.L
    parity = (i%2)+1
    bond(io, i, j, chain.z[parity], chain.xy[parity], chain.coeff)
  end
  close(io)
end

