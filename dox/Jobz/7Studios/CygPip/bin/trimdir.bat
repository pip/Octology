call FlipStr %1
if "%@index[%flip,*]" != "-1" set flip=%@instr[%@inc[%@index[%flip,\]],%@len[%flip],%flip]
if "%@index[%flip,\]" == "0" set flip=%@instr[1,%@len[%flip],%flip]
if "%@index[%flip,\]" != "-1" set flip=%@instr[0,%@index[%flip,\],%flip]
call FlipStr %flip
set trim=%flip\
if "%flip" == "" set trim=
set flip=
