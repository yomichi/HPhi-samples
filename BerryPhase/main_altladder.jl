include("berryphase.jl")

using BerryPhase

const L = 4
const delta = 0.5
const rungs = 1.2:0.1:1.7

const M = (length(ARGS)>0 ? parse(Int, ARGS[1]) : 16)

bp_leg(rung) = berryphase(altladder(L, 1.0, 1.0, delta, rung, rung, :plus_leg), M, canonical=false)
bp_rung(rung) = berryphase(altladder(L, 1.0, 1.0, delta, rung, rung, :rung), M, canonical=false)

bp_legs = map(bp_leg, rungs)
bp_rungs = map(bp_rung, rungs)

open("res.dat", "w") do io
  for (r,bl, br) in zip(rungs, bp_legs, bp_rungs)
    println(io, r, " ", bl/pi, " ", br/pi)
  end
end

