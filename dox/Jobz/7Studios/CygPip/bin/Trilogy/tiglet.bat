@pushd c:\pip\4dos\fig\
@perl tiglet.pl %&
@popd
@if exist c:\pip\4dos\fig\dfaltout.txt copy c:\pip\4dos\fig\dfaltout.txt .
