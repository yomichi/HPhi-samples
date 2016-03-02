import subprocess

def energy_gap():
  res = subprocess.check_output(['tail', '-n', '1', 'output/zvo_Lanczos_Step.dat'])
  enes = map(float, res.split()[1:])
  return enes[1]-enes[0]

def energies():
  res = subprocess.check_output(['tail', '-n', '1', 'output/zvo_Lanczos_Step.dat'])
  return map(float, res.split()[1:])
