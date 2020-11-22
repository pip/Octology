iff "%1" == "" then ^ javac %JavaFile%.java ^ java %JavaFile% ^
elseiff "%1" == "n" then ^ java %JavaFile% ^
else set JavaFile=%1 ^ javac %1.java ^ java %1 ^
endiff
