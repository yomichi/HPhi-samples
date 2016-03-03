module BerryPhase

export inputfiles, interall, eigenvec, berryphase
export Model

abstract Model
include("../util.jl/bond.jl")

function header_interall(io, m::Model)
  println(io,
"""
=== header
NInterAll $(length(m.coeff) * num_bonds(m))
=== reserved
=== reserved
=== end of header """)
end

include("dimer.jl")
include("alt-chain.jl")
include("alt-ladder.jl")

include("mkparams.jl")
include("eigenvec.jl")

function berryphase(model::Model, M::Integer=10)
  generate_defs(model)
  interall(model, 0.0)
  run(pipeline(`../HPhi -e namelist.def`, stdout="std.out", stderr="std.err", append=true))

  bp = 0.0
  vec0 = eigenvec()
  N = length(vec0)

  ref = [complex(float(i)) for i in 1:N]

  #  ref = zeros(Complex128, N)
  #  ref[end] = one(Complex128)

  # ref = rand(Complex128, N)

  normalize!(ref)
  gauge_fix!(vec0, ref)
  vec_old = deepcopy(vec0)
  dt = 2pi/M
  for i in 1:(M-1)
    t = i*dt
    @show t
    interall(model, t)
    run(pipeline(`../HPhi -e namelist.def`, stdout="std.out", stderr="std.err", append=true))
    vec_new = eigenvec()
    gauge_fix!(vec_new, ref)
    ip = zero(Complex128)
    @inbounds for j in 1:N
      ip += vec_new[j]' * vec_old[j]
      vec_old[j] = vec_new[j]
    end
    bp += angle(ip)
  end
  ip = dot(vec0, vec_old)
  bp += angle(ip)
  return mod(bp, 2pi)
end

end ## of module BerryPhase

