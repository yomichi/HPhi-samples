include("berryphase.jl")

using BerryPhase

const L = 8
const Jz = 1.0
const Jxy = 1.0

const deltas = [0.0, 0.2, 0.4, 0.6]
const S2 = 2
const M = 16

bp(delta) = berryphase(altchain(S2, L, Jz, Jxy, delta), M)

bps = map(bp, deltas)

open("res.dat", "w") do io
  for (d,b) in zip(deltas, bps)
    println(io, d, " ", b/pi)
  end
end

