pushd j:\Projects\Steve\BloodCpp.bak\
if not exist St%@instr[0,2,%_date]%@instr[3,2,%_date]%@instr[6,2,%_date] @call mc St%@instr[0,2,%_date]%@instr[3,2,%_date]%@instr[6,2,%_date].%@instr[0,2,%_time]%@instr[3,1,%_time]
cdd c:\Projects\Blood\
copy *.cpp j: /s
copy *.h j: /s
j:
cd..
dir
popd
