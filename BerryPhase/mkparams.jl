function inputfiles(L::Integer)
  NameList()
  CalcMod()
  ModPara(L)
  LocSpin(L)
end

function CalcMod()
const io = open("calcmod.def", "w")
println(io,
  """
  CalcType 0
  CalcModel   1
  OutputEigenVec 1 """)
close(io)
end

function ModPara(L::Integer)
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
  Nsite          $(L)    
  2Sz            0    
  Lanczos_max    2000 
  initial_iv     1    
  nvec           1    
  exct           1    
  LanczosEps     14   
  LanczosTarget  2    
  LargeValue     7.500000000000000e-01    
  NumAve         5    
  ExpecInterval  20 """)
  close(io)
end

function LocSpin(L::Integer)
  const io = open("locspin.def", "w")
  println(io,
  """
  === header
  NlocalSpin $L
  === reserved
  === reserved
  === end of header """)
  for i in 0:(L-1)
    println(io, i, " 1")
  end
  close(io)
end

function NameList()
  const io = open("namelist.def", "w")
  println(io,
  """
  CalcMod calcmod.def
  ModPara modpara.def
  LocSpin locspin.def
  InterAll interall.def """)
end

