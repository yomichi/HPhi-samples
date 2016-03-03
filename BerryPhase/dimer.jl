export Dimer, dimer

type Dimer <: Model
  Jz :: Float64
  Jxy :: Float64
end
dimer(Jz::Real, Jxy::Real) = Dimer(Jz, Jxy)
dimer(J::Real) = dimer(J,J)
num_sites(::Dimer) = 2
num_bonds(::Dimer) = 1

function interall(dimer::Dimer, t::Real = 0.0)
  const io = open("interall.def", "w")
  print_header(io, dimer)
  z = 0.25dimer.Jz
  xy = 0.5dimer.Jxy*cis(t)

  bond(io, 0, 1, z, xy)

  close(io)
end

function print_header(io, dimer::Dimer)
println(io,
"""
=== header
NInterAll 6
=== reserved
=== reserved
=== end of header """)
end

