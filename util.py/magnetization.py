import subprocess

def magnetization(L,S2=1):
  d = {}
  with open('output/zvo_energy.dat') as inp:
    for line in inp:
      words = line.split()
      d[words[0]] = float(words[1])
  return -0.5*S2*d['Sz']/L
