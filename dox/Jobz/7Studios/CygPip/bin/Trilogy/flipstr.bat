set flip=
for /l %x in (%@len[%1],-1,0) do set flip=%flip%%@instr[%x,1,%1]
