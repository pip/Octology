@echo off
set prompt=$e[1;33m[$e[36m%PipsUser%$e[37m@$e[36m%PipsHost%$e[32m($e[35mLose98$e[32m)$e[31m%%@execstr[pt]$e[34m$P$e[33m]$e[1;32m
if "%1" != "" set prompt=[%PipsUser%@%PipsHost% %%@execstr[pt] $P]
::if "%1" == "4nt" prompt `%@exec[@color 0e & echos [ & color 0b & echos %PipsUser% & color 0f & echos @ & color 0b & echos %PipsHost% & color 0c & echos %@execstr[pt] & color 09 & echos %@lfn[%_cwd] & color 0e & echos ^] & color 0a & echos ]`
::if "%1" == "4nt" prompt `%@exec[@color 0f & echos [ & color 0b & echos %PipsUser% & color 09 & echos @ & color 0b & echos %PipsHost% & color 0c & echos %@execstr[pt -4] & color 0e & echos %@lfn[%_cwd] & color 0f & echos ^] & color 0a & echos ]`
if "%1" == "4NT" prompt `%@exec[@color 0f & echos [ & color 0b & echos %PipsUser% & color 09 & echos @ & color 0b & echos %PipsHost% & color 0c & echos %@execstr[pt -4] & color 0e & echos %@lfn[%_cwd] & color 0f & echos ^] & color 07 & echos ]`
:: 0e Y, 0f W, 0b C, 09 U,
::$e[1;33m[$e[36m%PipsUser%$e[37m@$e[36m%PipsHost%$e[31m%%@execstr[pt]$e[34m$P$e[33m]$e[1;32m
if "%1" == "k" set prompt=$e[1;33m[$e[36m%PipsUser%$e[37m@$e[36m%PipsHost%$e[31m%%@execstr[pt]$e[34m$P$e[33m]$e[1;32m
::@PROMPT=$e[1;30m[$e[31m$d$e[30m][$e[32m$M$e[30m][$e[34m$P$e[30m]$e[1;32m
