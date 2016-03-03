typealias BondCoeff Tuple{Int, Int, Int, Int, Float64}
typealias BondCoeffs Vector{BondCoeff}

function bond_coeffs(S2::Integer)
  S = 0.5S2
  coeff = BondCoeff[]
  
  ## diagonal
  for si in 0:S2
    mi = si-S
    for sj in 0:S2
      mj = sj-S
      JZ = mi*mj
      if JZ == 0.0
        continue
      end
      push!(coeff, (si, si, sj, sj, JZ))
    end
  end

  ## offdiagonal
  cp = zeros(S2+1)
  cm = zeros(S2+1)
  for s in 0:S2
    m = s - S
    cp[s+1] = sqrt((S-m)*(S+m+1))
    cm[s+1] = sqrt((S+m)*(S-m+1))
  end
  for si in 0:S2
    mi = si-S

    for sj in 0:S2
      mj = sj-S

      ## S^+ S^-
      si2 = si+1
      sj2 = sj-1
      if si2 <= S2 && sj2 >= 0
        c = 0.5cp[si+1] * cm[sj+1]
        push!(coeff, (si2, si, sj2, sj, c))
      end

      ## S^- S^+
      si2 = si-1
      sj2 = sj+1
      if si2 >= 0 && sj2 <= S2
        c = 0.5cm[si+1] * cp[sj+1]
        push!(coeff, (si2, si, sj2, sj, c))
      end
    end
  end

  return coeff
end

@inline function bond(io, i::Integer,j::Integer,z::Real,xy::Real, coeffs::BondCoeffs)
  bond(io, i,j,z,complex(xy,zero(xy)), coeffs)
end

@inline function bond(io, i::Integer, j::Integer, z::Real, xy::Complex, coeffs::BondCoeffs)
  for coeff in coeffs
    s1,s2,s3,s4,c = coeff
    Js = [c*xy', complex(z*c, 0.0), c*xy]
    J = Js[s1-s2+2]
    #            i  s1 i  s2 j  s3 j  s4 J.re J.im
    @printf(io, "%d %d %d %d %d %d %d %d %llg %llg \n", i, s1, i, s2, j, s3, j, s4, J.re, J.im)
  end
end

