include("berryphase.jl")

using BerryPhase

const S2 = (length(ARGS) >= 1 ? parse(Int, ARGS[1]) : 1)
const M = (length(ARGS) >= 2 ? parse(Int, ARGS[2]) : 10)

bp = berryphase(dimer(S2,1.0), M)

println("γ/π = ", bp/pi)

