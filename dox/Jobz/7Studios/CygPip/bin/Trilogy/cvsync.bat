pushd
set CVSPARMS=-z9 -q update -P -d
cdd c:\Mucha_Lucha\docs\
echo cvs %CVSPARMS% in C:\Mucha_Lucha\docs\...
cvs %CVSPARMS%
cdd c:\Mucha_Lucha\mucha_builds\
echo cvs %CVSPARMS% in C:\Mucha_Lucha\mucha_builds\...
cvs %CVSPARMS%
cdd c:\Mucha_Lucha\mucha_lucha\
echo cvs %CVSPARMS% in C:\Mucha_Lucha\mucha_lucha\...
cvs %CVSPARMS%
cdd c:\Mucha_Lucha\Mucha_Lucha_Art\
echo cvs %CVSPARMS% in C:\Mucha_Lucha\Mucha_Lucha_Art\...
cvs %CVSPARMS%
cdd c:\Mucha_Lucha\Mucha_Lucha_Design\
echo cvs %CVSPARMS% in C:\Mucha_Lucha\Mucha_Lucha_Design\...
cvs %CVSPARMS%

cdd c:\src\bbengine\
echo cvs %CVSPARMS% in C:\src\bbengine\...
cvs %CVSPARMS%
cdd c:\src\bbpython\
echo cvs %CVSPARMS% in C:\src\bbpython\...
cvs %CVSPARMS%
cdd c:\src\bbtools\
echo cvs %CVSPARMS% in C:\src\bbtools\...
cvs %CVSPARMS%
cdd c:\src\bbtoolsR\
echo cvs %CVSPARMS% in C:\src\bbtoolsR\...
cvs %CVSPARMS%

popd
