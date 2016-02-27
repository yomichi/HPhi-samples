@inline function print_bond(io, i, j, z, xy)
  ## diagonal
  @printf(io, "%d 0 %d 0 %d 0 %d 0 %llg 0.0 \n", i,i,j,j, z)
  @printf(io, "%d 1 %d 1 %d 1 %d 1 %llg 0.0 \n", i,i,j,j, z)
  @printf(io, "%d 0 %d 0 %d 1 %d 1 %llg 0.0 \n", i,i,j,j, -z)
  @printf(io, "%d 1 %d 1 %d 0 %d 0 %llg 0.0 \n", i,i,j,j, -z)

  ## offdiagonal
  @printf(io, "%d 0 %d 1 %d 1 %d 0 %llg %llg \n", i,i,j,j, xy.re, xy.im)
  @printf(io, "%d 1 %d 0 %d 0 %d 1 %llg %llg \n", i,i,j,j, xy.re, -xy.im)
end
