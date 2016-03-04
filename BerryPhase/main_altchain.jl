include("berryphase.jl")

using BerryPhase

const L = 6
const Jz = 1.0
const Jxy = 1.0

const deltas = [0.22, 0.24, 0.26, 0.28]
const S2 = 2
const M = 10

open("res.dat", "w") do io
  for delta in deltas
    bp = berryphase(altchain(S2, L, Jz, Jxy, delta), M)
    println(io, delta, " ", bp/pi)
    println(delta, " ", bp/pi)
  end
end

