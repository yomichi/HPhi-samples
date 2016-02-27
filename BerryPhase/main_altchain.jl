include("berryphase.jl")

using BerryPhase

const L = 8
const Jz = 1.0
const Jxy = 1.0
const deltas = [-0.5, -0.1, 0.0, 0.1, 0.5]

const M = (length(ARGS)>0 ? parse(Int, ARGS[1]) : 16)

bp(delta) = berryphase(altchain(L, Jz, Jxy, delta), M, canonical=false)

bps = map(bp, deltas)

open("res.dat", "w") do io
  for (d,b) in zip(deltas, bps)
    println(io, d, " ", b/pi)
  end
end

