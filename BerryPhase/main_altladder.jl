include("berryphase.jl")

using BerryPhase

const L = 4
const delta = 0.5
const rungs = 1.2:0.1:1.7

const M = (length(ARGS)>0 ? parse(Int, ARGS[1]) : 10)

bp_leg(rung) = berryphase(altladder(1, L, 1.0, 1.0, delta, rung, rung, :plus_leg), M)
bp_rung(rung) = berryphase(altladder(1, L, 1.0, 1.0, delta, rung, rung, :rung), M)

open("res.dat", "w") do io
  for r in rungs
    bl = bp_leg(r)
    br = bp_rung(r)
    println(r, " ", bl/pi, " ", br/pi)
    println(io, r, " ", bl/pi, " ", br/pi)
  end
end

