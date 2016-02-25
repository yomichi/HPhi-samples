module BerryPhase

export interall, eigenvec, berryphase

include("mkparams.jl")
include("mkInterAll.jl")

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
  ip = cis(angle(dot(vec, ref)))
  @inbounds for i in 1:length(vec)
    vec[i] *= ip
  end
  vec
end

function normalize!(vec)
  s = dot(vec,vec)
  s = 1.0/sqrt(s)
  @inbounds for i in 1:length(vec)
    vec[i] *= s
  end
end

function berryphase(L::Integer, Jz::Real;
                    delta::Real=0.0, Jxy::Real=Jz,
                    M::Integer=10)

  @show delta

  InterAll(L, Jz, delta=delta, Jxy=Jxy, t=0.0)
  run(`../HPhi -e namelist.def`)

  bp = 0.0
  vec0 = eigenvec()
  N = length(vec0)
  #=
  ref = rand(Complex128, N)
  normalize!(ref)
  gauge_fix!(vec0, ref)
  =#
  vec_old = deepcopy(vec0)
  dt = 2pi/M
  for i in 1:(M-1)
    InterAll(L, Jz, delta=delta, Jxy=Jxy, t=i*dt)
    run(`../HPhi -e namelist.def`)
    vec_new = eigenvec()
    # gauge_fix!(vec_new, ref)
    ip = zero(Complex128)
    @inbounds for i in 1:N
      ip += vec_new[i]' * vec_old[i]
      vec_old[i] = vec_new[i]
    end
    bp *= angle(ip)
  end
  bp += angle(dot(vec0, vec_old))
  return mod(bp, 2pi)
end

end ## of module BerryPhase

