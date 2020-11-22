if direxist %1 pushd %1
del /e /q *.bak
if direxist %1 popd
