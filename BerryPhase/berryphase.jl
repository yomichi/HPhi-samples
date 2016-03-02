module BerryPhase

export inputfiles, interall, eigenvec, berryphase
export Model

abstract Model
include("bond.jl")
include("dimer.jl")
include("alt-chain.jl")
include("alt-ladder.jl")

include("mkparams.jl")

function eigenvec()
  const io = open(joinpath("output", "zvo_eigenvec_0_rank_0.dat"))
  const N = read(io, Int)
  res = zeros(Complex128, N)
  @inbounds for i in 1:N
    re = read(io, Float64)
    img = read(io, Float64)
    res[i] = complex(re,img)
  end
  return res
end

function gauge_fix!(vec, ref)
  return vec
  ip = cis(angle(dot(vec, ref)))
  @inbounds for i in 1:length(vec)
    vec[i] *= ip
  end
  vec
end

function normalize!(vec)
  s = sum(abs2(vec))
  s = 1.0/sqrt(s)
  @inbounds for i in 1:length(vec)
    vec[i] *= s
  end
end

function berryphase(model::Model, M::Integer=10; canonical::Bool=true)
  inputfiles(num_sites(model), canonical=canonical)
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

