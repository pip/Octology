@echo off
:: Load the Registry with saved PuTTY data (including setting RandSeedFile):
RegEdit /s  PuTY.reg
Start   /w  PuTTY.exe
:: Save PuTTY data from the Registry:
RegEdit /ea PuTY.reg HKEY_CURRENT_USER\Software\SimonTatham\PuTTY
:: Delete the PuTTY data from the Registry (which is unnecessary):
::RegEdit /s  PuTYDel.reg

::You will need a file called (say) PuTY.bat which imports the contents of
::a file into the Registry, then runs PuTTY, exports the contents of the
::Registry back into the file, and deletes the Registry entries. This can
::all be done using the Regedit command line options, so it's all automatic.
::
::This batch file needs two auxiliary files: PuTYRnd.Reg which sets up an
::initial safe location for the PuTY.Rnd random seed file, and PuTYDel.Reg
::which destroys everything in the Registry once it's been successfully
::saved back to the file.
::
::Here is PuTYDel.reg:
::REGEDIT4
::
::[-HKEY_CURRENT_USER\Software\SimonTatham\PuTTY]
::
::Here is PuTYRnd.reg (example):
::REGEDIT4
::
::[HKEY_CURRENT_USER\Software\SimonTatham\PuTTY]
::"RandSeedFile"="C:\\home\\Pip\\bin\\PuTY.rnd"
::
::You should replace A:\PuTTY.rnd with the location where you want to store
::your random number data. If the aim is to carry around PuTTY and its
::settings on one floppy, you probably want to store it on the floppy.
