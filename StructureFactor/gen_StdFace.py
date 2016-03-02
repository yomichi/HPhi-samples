execfile('../util.py/generate_defs.py')

from sys import argv, exit

def gen_stdface(L, S2):
  params = {
      'model' : 'Spin',
      'lattice' : 'chain lattice',
      'method' : 'Lanczos',
      '2S' : S2,
      '2Sz' : 0,
      'L' : L,
      }
  generate_stdface(params)

if __name__ == '__main__':
  if len(argv) < 3:
    print "usage: {} <2S> <L>".format(argv[0])
    exit()
  S2 = int(argv[1])
  L = int(argv[2])
  gen_stdface(L, S2)
