execfile('interall.py')
execfile('../util.py/energy.py')

import numpy as np

L = 8
Delta = 0.5

deltas = np.linspace(0.0, 1.0, 21)

common_params = {
    'model' : 'Spin',
    'lattice' : 'chain lattice',
    'method' : 'Lanczos',
    'L' : L,
    '2S' : 2,
    '2Sz' : 0}

with open('res.dat', 'w') as output:
  for delta in deltas:
    generate_defs(common_params)
    interall(L, delta, Delta, False)
    subprocess.call(['../HPhi.sh', '-e', 'namelist.def'])
    enes = energies()
    ge = enes[0]

    interall(L, delta, Delta, True)
    subprocess.call(['../HPhi.sh', '-e', 'namelist.def'])
    enes = energies()
    output.write('{} {} {} {}\n'.format(delta, ge, enes[0], enes[1]))

