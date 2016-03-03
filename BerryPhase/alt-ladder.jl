export AltLadder, altladder

type AltLadder <: Model
  L :: Int
  lz :: Tuple{Float64, Float64}
  lx :: Tuple{Complex128, Complex128}
  rz :: Float64
  rx :: Complex128
  twistedmask :: Tuple{Bool, Bool, Bool}
  function AltLadder(L::Integer, Jlz::Real, Jlx::Real, delta::Real, Jrz::Real, Jrx::Real, twistedbond::Symbol)
    if twistedbond == :rung 
      twistedmask = (true, false, false)
    elseif twistedbond == :plus_leg
      twistedmask = (false, true, false)
    elseif twistedbond == :minus_leg
      twistedmask = (false, false, true)
    else
      error("twistedbond should be :rung, :plus_leg, or :minus_leg")
    end
    lz = (0.25Jlz*(1.0+delta), 0.25Jlz*(1.0-delta))
    lx = (0.5Jlx*complex(1.0+delta), 0.5Jlx*complex(1.0-delta))
    rz = 0.25Jrz
    rx = complex(0.5Jrx)
    new(L, lz, lx, rz, rx, twistedmask)
  end
end
altladder(L::Integer, Jlz::Real, Jlx::Real, delta::Real, Jrz::Real, Jrx::Real, twist::Symbol) = AltLadder(L, Jlz, Jlx, delta, Jrz, Jrx, twist)
num_sites(ladder::AltLadder) = 2ladder.L

function interall(ladder::AltLadder, t::Real=0.0)
  const io = open("interall.def", "w")
  print_header(io, ladder)

  L = ladder.L

  twist = cis(t)
  cone = one(Complex128)
  bond(io, 0, L, ladder.rz, ladder.rx * ifelse(ladder.twistedmask[1], twist, cone))
  bond(io, 0, 1, ladder.lz[1], ladder.lx[1] * ifelse(ladder.twistedmask[2], twist, cone))
  bond(io, L, L+1, ladder.lz[2], ladder.lx[2] * ifelse(ladder.twistedmask[3], twist, cone))

  @inbounds for i in 1:(L-1)
    j = (i+1)%L

    parity = i%2
    # first leg
    bond(io, i, j, ladder.lz[parity+1], ladder.lx[parity+1])
    # second leg
    bond(io, i+L, j+L, ladder.lz[2-parity], ladder.lx[2-parity])
  end

  ## rung
  @inbounds for i in 1:(L-1)
    bond(io, i, i+L, ladder.rz, ladder.rx)
  end

  close(io)
end

function print_header(io, ladder::AltLadder)
println(io,
"""
=== header
NInterAll $(18ladder.L)
=== reserved
=== reserved
=== end of header """)
end

