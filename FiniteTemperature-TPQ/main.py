import subprocess
import sys
from math import sqrt

execfile('../util.py/generate_defs.py')
from evaluate import *

S2 = 1
LargeValue = 1.0

def run_HPhi():
  subprocess.call( ['../HPhi.sh', "-s","StdFace.def"] )

def run(L):
  params = {
      'model' : 'SpinGC',
      'lattice' : 'chain lattice',
      'method ' : 'TPQ',
      'L' : L,
      'J' : 1.0,
      'LargeValue' : LargeValue,
      }
  generate_defs(params)
  run_HPhi()
  evaluate(L, 5)

if __name__ == '__main__' : 
  argc = len(sys.argv)
  if argc < 2:
    print "usage: {} <L>".format(sys.argv[0])
    sys.exit(-1)

  L = int(sys.argv[1])
  run(L)

