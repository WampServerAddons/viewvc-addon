installer\temp\python-2.6.msi
installer\temp\pywin32-214.win32-py2.6.exe
installer\bin\unzip.exe -q installer\temp\svn-win32-1.6.6_py26.zip -d installer\temp

mkdir installer\temp\pyd
copy installer\temp\svn-win32-1.6.6\python\libsvn\*.dll installer\temp\pyd
for /R %%I in (installer\temp\pyd\*.dll) do ren "%%I" %%~nI.pyd
move installer\temp\pyd\* installer\temp\svn-win32-1.6.6\python\libsvn

move installer\temp\svn-win32-1.6.6\python\svn c:\python26\Lib
move installer\temp\svn-win32-1.6.6\python\libsvn c:\python26\Lib

installer\bin\unzip.exe -q installer\temp\viewvc-1.0.12.zip -d installer\temp
cd installer\temp\viewvc-1.0.12
python viewvc-install --prefix=c:\wamp\apps\viewvc1.0.12 --destdir=""
cd ..\..\

mkdir installer\temp\diffutils2.8.7-1
installer\bin\unzip.exe -q installer\temp\diffutils-2.8.7-1-dep.zip bin\* -d installer\temp\diffutils2.8.7-1
installer\bin\unzip.exe -q installer\temp\diffutils-2.8.7-1-bin.zip bin\* -d installer\temp\diffutils2.8.7-1

mkdir c:\wamp\bin\diffutils
move installer\temp\diffutils2.8.7-1 c:\wamp\bin\diffutils

copy wamp\alias\viewvc.conf c:\wamp\alias
copy wamp\apps\viewvc1.0.12\viewvc.conf c:\wamp\apps\viewvc1.0.12

pause
