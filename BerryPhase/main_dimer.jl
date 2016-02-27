include("berryphase.jl")

using BerryPhase

const M = (length(ARGS) > 0 ? parse(Int, ARGS[1]) : 10)
const canonical = false

bp = berryphase(dimer(1.0), M, canonical=canonical)

println("γ/π = ", bp/pi)

