include("berryphase.jl")

using BerryPhase

const M = (length(ARGS) > 0 ? parse(Int, ARGS[1]) : 10)

bp = berryphase(dimer(1.0), M, canonical=false)

println("γ/π = ", bp/pi)

