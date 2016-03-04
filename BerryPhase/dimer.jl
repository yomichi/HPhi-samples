export Dimer, dimer

type Dimer <: Model
  S2 :: Int
  Jz :: Float64
  Jxy :: Float64
  coeff :: BondCoeffs
  function Dimer(S2, Jz, Jxy)
    c = bond_coeffs(S2)
    new(S2, Jz, Jxy, c)
  end
end
dimer(S2::Integer, Jz::Real, Jxy::Real) = Dimer(S2,Jz, Jxy)
dimer(S2::Integer, J::Real) = dimer(S2,J,J)
num_sites(::Dimer) = 2
num_bonds(::Dimer) = 1

function interall(dimer::Dimer, t::Real = 0.0)
  const io = open("interall.def", "w")
  header_interall(io, dimer)
  bond(io, 0, 1, dimer.Jz, dimer.Jxy*cis(t), dimer.coeff)

  close(io)
end

