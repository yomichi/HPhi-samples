function generate_defs(model::Model)
  namelist()
  calcmod()
  modpara(num_sites(model))
  locspin(model.S2, num_sites(model))
  interall(model)
end

function calcmod()
  const io = open("calcmod.def", "w")
  println(io,
    """
    CalcType 0
    CalcModel   4
    OutputEigenVec 1 """)
  close(io)
end

function modpara(nsites::Integer)
  const io = open("modpara.def", "w")
  println(io,
  """
  --------------------
  Model_Parameters   0
  --------------------
  HPhi_Cal_Parameters
  --------------------
  CDataFileHead  zvo
  CParaFileHead  zqp
  --------------------
  Nsite          $nsites  
  Lanczos_max    3000
  initial_iv     1
  nvec           1
  exct           1
  LanczosEps     14
  LanczosTarget  1""")
  close(io)
end

function locspin(S2::Integer, nsites::Integer)
  const io = open("locspin.def", "w")
  println(io,
  """
  === header
  NlocalSpin $nsites
  === reserved
  === reserved
  === end of header """)
  for i in 0:(nsites-1)
    println(io, i, " ", S2)
  end
  close(io)
end

function namelist()
  const io = open("namelist.def", "w")
  println(io,
  """
  CalcMod calcmod.def
  ModPara modpara.def
  LocSpin locspin.def
  InterAll interall.def """)
  close(io)
end

