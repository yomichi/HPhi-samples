import sys
from math import sqrt

execfile('../util.py/generate_defs.py')

def evaluate(N, NumAve):
  Ts = []
  Ts2 = []
  enes = []
  enes2 = []
  specs = []
  specs2 = []
  with open("output/SS_rand0.dat") as io:
    io.readline() ## discard the first comment line
    with open("specheat_0.dat", "w") as output:
      for line in io:
        vals = map(float, line.split())
        beta = vals[0]
        T = 1.0/beta
        ene = vals[1]
        spec = beta * beta * (vals[2] - ene*ene) / N
        Ts.append(T)
        Ts2.append(T*T)
        enes.append(ene)
        enes2.append(ene*ene)
        specs.append(spec)
        specs2.append(spec*spec)
        output.write('{} {} {}\n'.format(T, ene, spec))
  for i in range(1,NumAve):
    with open("output/SS_rand{}.dat".format(i)) as io:
      io.readline() ## discard the first comment line
      with open("specheat_{}.dat".format(i), "w") as output:
        for j, line in enumerate(io):
          vals = map(float, line.split())
          beta = vals[0]
          T = 1.0/beta
          ene = vals[1]
          spec = beta * beta * (vals[2] - ene*ene) / N
          Ts[j] += T
          Ts2[j] += T*T
          enes[j] += ene
          enes2[j] += ene*ene
          specs[j] += spec
          specs2[j] += spec*spec
          output.write('{} {} {}\n'.format(T, ene, spec))
  with open("specheat.dat", "w") as output:
    N1 = NumAve - 1
    for t,t2, e,e2, s,s2 in zip(Ts, Ts2, enes, enes2, specs, specs2):
      m_t = t/NumAve
      dev_t = sqrt(abs(t2/(N1) - t*t/(NumAve*N1)))
      m_e = e/NumAve
      dev_e = sqrt(abs(e2/(N1) - e*e/(NumAve*N1)))
      m_s = s/NumAve
      dev_s = sqrt(abs(s2/(N1) - s*s/(NumAve*N1)))
      output.write("{} {} {} {} {} {}\n".format(m_t, dev_t, m_e, dev_e, m_s, dev_s))

if __name__ == '__main__' : 
  argc = len(sys.argv)
  if argc < 2:
    print "usage: {} <N>".format(sys.argv[0])
    sys.exit(-1)

  N = int(sys.argv[1])
  evaluate(N, 5)

