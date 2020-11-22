iff "%1" == "" then
  echo please provide param
else
  echo %@name[%1] name
  echo %@path[%1] path
  echo %@filename[%1] filename
  echo %@full[%1] full
  echo %@lfn[%1] lfn
  echo %@sfn[%1] sfn
  echo %@ext[%1] ext
  echo %@expand[%1] expand
  echo %@truename[%1] truename
  if "%_cmdproc" == "4NT" echo %@altname[%1] altname
  if not exist %1 echo %1 does not exist
  if exist %1 echo %1 exists
  echo %_batchname batname
endiff
