# Testing JoyStikz axes (# then ID mapz) && buttons (same) under Ubuntu10.10 on Akuma by installing joystick package && repeatedly running:
[pip@AkuB1KFiAB~]jscal -q /dev/input/js0

# SuperStreetFighter4 big black
jscal -u 6,0,1,2,5,16,17,13,304,305,306,307,308,309,310,311,312,313,314,315,316 /dev/input/js0

# Intec CombatArcade little gray
jscal -u 7,0,1,2,5,16,17,40,16,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303 /dev/input/js0

# ArcadeFighter big red
jscal -u 28,0,1,2,5,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,19,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,720,721,722 /dev/input/js0

# RadioShack PS2->USB adapter (same results for SoulCali green, Ryu pad red, DualShock2 blue)
jscal -u 7,0,1,2,5,16,17,40,12,288,289,290,291,292,293,294,295,296,297,298,299 /dev/input/js0
