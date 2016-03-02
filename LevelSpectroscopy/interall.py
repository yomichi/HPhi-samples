execfile('util.py')

def interall(L, delta=0.0, Delta=1.0, twisted = False):
  zs = [Delta*(1.0+delta), Delta*(1.0-delta)]
  xs = [1.0+delta, 1.0-delta]
  with open('zInterAll.def', 'w') as output:
    interall_header(output, L, S2=2)
    for i in range(L-1):
      z = zs[i%2]
      x = xs[i%2]
      bond(output, i,i+1,z,x, S2=2)
    z = zs[(L-1)%2]
    x = xs[(L-1)%2]
    if twisted:
      x = -x
    bond(output,L-1,0,z,x, S2=2)

