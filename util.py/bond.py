def bond(output, i,j,Jz,Jx,S2=1):
  if S2==1:
    bond_half(output, i,j,Jz,Jx)
  elif S2==2:
    bond_one(output, i,j,Jz,Jx)
  else:
    error("S2 should be 1 or 2.")

def bond_half(output, i,j, Jz,Jx):
  z = 0.25*Jz
  x = 0.5*Jx
  # diagonal
  output.write('{} 0 {} 0 {} 0 {} 0 {} 0.0 \n'.format(i,i,j,j,z))
  output.write('{} 1 {} 1 {} 0 {} 0 {} 0.0 \n'.format(i,i,j,j,-z))
  output.write('{} 0 {} 0 {} 1 {} 1 {} 0.0 \n'.format(i,i,j,j,-z))
  output.write('{} 1 {} 1 {} 1 {} 1 {} 0.0 \n'.format(i,i,j,j,z))
  # off-diagonal
  # S_i^+ S_j^-
  output.write('{} 1 {} 0 {} 0 {} 1 {} 0.0 \n'.format(i,i,j,j,x))
  # S_j^+ S_i^-
  output.write('{} 1 {} 0 {} 0 {} 1 {} 0.0 \n'.format(j,j,i,i,x))

def bond_one(output, i,j, Jz,Jx):
  # diagonal
  output.write('{} 0 {} 0 {} 0 {} 0 {} 0.0 \n'.format(i,i,j,j,Jz))
  output.write('{} 2 {} 2 {} 0 {} 0 {} 0.0 \n'.format(i,i,j,j,-Jz))
  output.write('{} 0 {} 0 {} 2 {} 2 {} 0.0 \n'.format(i,i,j,j,-Jz))
  output.write('{} 2 {} 2 {} 2 {} 2 {} 0.0 \n'.format(i,i,j,j,Jz))
  # off-diagonal
  # S_i^+ S_j^-
  output.write('{} 1 {} 0 {} 0 {} 1 {} 0.0 \n'.format(i,i,j,j,Jx))
  output.write('{} 2 {} 1 {} 0 {} 1 {} 0.0 \n'.format(i,i,j,j,Jx))
  output.write('{} 1 {} 0 {} 1 {} 2 {} 0.0 \n'.format(i,i,j,j,Jx))
  output.write('{} 2 {} 1 {} 1 {} 2 {} 0.0 \n'.format(i,i,j,j,Jx))
  # S_j^+ S_i^-
  output.write('{} 1 {} 0 {} 0 {} 1 {} 0.0 \n'.format(j,j,i,i,Jx))
  output.write('{} 2 {} 1 {} 0 {} 1 {} 0.0 \n'.format(j,j,i,i,Jx))
  output.write('{} 1 {} 0 {} 1 {} 2 {} 0.0 \n'.format(j,j,i,i,Jx))
  output.write('{} 2 {} 1 {} 1 {} 2 {} 0.0 \n'.format(j,j,i,i,Jx))

def interall_header(output, L, S2=1):
  output.write('=== header start\n')
  output.write('NInterAll {}\n'.format(6*S2*L))
  output.write('=== header (reserved)\n')
  output.write('=== header (reserved)\n')
  output.write('=== header end\n')
