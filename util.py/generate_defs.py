import subprocess
import string

def generate_stdface(params):
  with open('StdFace.def', 'w') as output:
    for p in params:
      if string.lower(p) in ("model", "lattice", "method"):
        output.write('{} = "{}"\n'.format(p, params[p]))
      else:
        output.write('{} = {}\n'.format(p, params[p]))

def generate_defs(params):
  generate_stdface(params)
  subprocess.call(["../HPhi.sh", '-sdry', 'StdFace.def'])

