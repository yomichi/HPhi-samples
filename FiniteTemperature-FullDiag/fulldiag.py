import math
from sys import argv, exit
import numpy as np

def load_result(N):
  es = []
  ms = []
  ge = None
  with open('output/zvo_phys_Nup8_Ndown8.dat') as inp:
    inp.readline() # discard the first line
    for line in inp:
      vals = map(float, line.split())
      e = vals[0]
      if ge == None:
        ge = e
      m = vals[2]/N
      es.append(e-ge)
      ms.append(m)
  es.reverse()
  ms.reverse()
  return es, ms, ge

def calc_phys(es, ms, ge, T, N):
  beta = 1.0/T
  Z = 0.0
  E = 0.0
  E2 = 0.0
  M = 0.0
  M2 = 0.0
  for e,m in zip(es, ms):
    bf = math.exp(-beta*e)
    Z += bf
    E += (ge+e)*bf
    E2 += (ge+e)*(ge+e)*bf
    M += m*bf
    M2 += m*m*bf
  E /= Z
  E2 /= Z
  M /= Z
  M2 /= Z
  C = beta * beta * (E2-E*E)/N
  chi = beta * (M2 - M*M)
  return { 'Z' : Z, 'E' : E, 'E2' : E2, 'M' : M, 'M2' : M2, 'C' : C, 'chi' : chi }

def print_result(Ts, N):
  es, ms, ge = load_result(N)
  with open('res.dat', 'w') as output:
    output.write("# T E M C chi")
    for T in Ts:
      p = calc_phys(es, ms, ge, T, N)
      output.write("{T} {E} {M} {C} {chi}\n".format(T=T, E=p['E'], M=p['M'], C=p['C'], chi=p['chi']))

if __name__ == '__main__':
  if len(argv) < 4 :
    print "usage : {} <N> <Tmin> <Tmax> (<Tnum>)".format(argv[0])
    exit()
  N = int(argv[1])
  Tmin = float(argv[2])
  Tmax = float(argv[3])
  Tnum = int(argv[4]) if len(argv) > 4  else 50
  Ts = np.linspace(Tmin, Tmax, Tnum)
  print_result(Ts, N)
