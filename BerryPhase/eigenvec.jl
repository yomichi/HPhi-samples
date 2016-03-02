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

