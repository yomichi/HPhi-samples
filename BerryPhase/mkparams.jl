function inputfiles(nsites::Integer; canonical::Bool = true)
  namelist()
  calcmod(canonical)
  modpara(nsites, canonical)
  locspin(nsites)
end

function calcmod(canonical::Bool)
  const io = open("calcmod.def", "w")
  println(io,
    """
    CalcType 0
    CalcModel   $(ifelse(canonical, 1, 4))
    OutputEigenVec 1 """)
  close(io)
end

function modpara(nsites::Integer, canonical::Bool)
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
  if canonical
    println(io, "2Sz            0")
  end
  close(io)
end

function locspin(nsites::Integer)
  const io = open("locspin.def", "w")
  println(io,
  """
  === header
  NlocalSpin $nsites
  === reserved
  === reserved
  === end of header """)
  for i in 0:(nsites-1)
    println(io, i, " 1")
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

