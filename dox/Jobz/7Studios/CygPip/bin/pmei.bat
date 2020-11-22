@echo off
pushd \strawberry-perl\perl\site\lib
perl -MCPAN -e "install '%1'"
popd
