@inline function bond(io, i::Integer,j::Integer,z::Real,xy::Real)
  bond(io, i,j,z,complex(xy,zero(xy)))
end

@inline function bond(io, i::Integer, j::Integer, z::Real, xy::Complex)
  ## diagonal
  @printf(io, "%d 0 %d 0 %d 0 %d 0 %llg 0.0 \n", i,i,j,j, z)
  @printf(io, "%d 1 %d 1 %d 1 %d 1 %llg 0.0 \n", i,i,j,j, z)
  @printf(io, "%d 0 %d 0 %d 1 %d 1 %llg 0.0 \n", i,i,j,j, -z)
  @printf(io, "%d 1 %d 1 %d 0 %d 0 %llg 0.0 \n", i,i,j,j, -z)

  ## offdiagonal
  @printf(io, "%d 0 %d 1 %d 1 %d 0 %llg %llg \n", i,i,j,j, xy.re, xy.im)
  @printf(io, "%d 1 %d 0 %d 0 %d 1 %llg %llg \n", i,i,j,j, xy.re, -xy.im)
end
