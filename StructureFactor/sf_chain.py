#!/usr/bin/env python

import cmath 
import numpy as np
import numpy.fft as fft
import subprocess
import sys

def wavenumbers(L):
  return np.linspace(0.0, np.pi, L/2+1)

def chain_correlations(L,S2):
  zs = np.zeros(L)
  zzs = np.zeros((L,L))
  with open("output/zvo_cisajs.dat") as inp:
    for line in inp:
      words = line.split()
      site = int(words[0])
      z = float(words[1]) - 0.5*S2
      zs[site] += z*float(words[4])
  with open("output/zvo_cisajscktalt.dat") as inp:
    for line in inp:
      words = line.split()
      si = int(words[0])
      sj = int(words[4])
      zi = float(words[1]) - 0.5*S2
      zj = float(words[5]) - 0.5*S2
      zzs[si,sj] += zi*zj*float(words[8])
  zzs -= np.outer(zs,zs)
  zzs *= (1.0/L)
  zs = np.zeros(L)
  for i in range(L):
    for j in range(L):
      zs[j-i] += zzs[i, j]
  return zs

def structure_factor(cs):
  L = len(cs)
  sf = fft.fft(cs).real
  return wavenumbers(L), sf[:L/2+1]

def run(L, S2):
  cs = chain_correlations(L, S2)
  ks, sf = structure_factor(cs)
  with open('correlation_S{}_L{}.dat'.format(0.5*S2,L), 'w') as output:
    for i in range(L/2+1):
      output.write('{} {}\n'.format(i, 4*cs[i]))
  with open('structure_S{}_L{}.dat'.format(0.5*S2,L), 'w') as output:
    for k,sf in zip(ks, sf):
      output.write('{} {}\n'.format(k,sf))

if __name__ == '__main__':
  if len(sys.argv) < 3:
    print "usage : {} <2S> <L>".format(sys.argv[0])
    sys.exit()

  S2 = int(sys.argv[1])
  L = int(sys.argv[2])

  run(L,S2)
