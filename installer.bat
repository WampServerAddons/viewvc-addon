@echo OFF
REM TODO use the call command to set some variables common to both the installer/uninstaller
REM TODO implement download functionallity
set VIEWVC_VERSION=1.0.12
set APACHE_VERSION=2.2.11
set DIFFUTILS_VERSION=2.8.7-1

set BIN=installer\bin
set TMP=installer\temp

set WAMP="c:\wamp"
set WAMP_DIFFUTILS=%WAMP%\bin\diffutils

set PYTHON="c:\python26"

set DIFFUTILS_FILE=diffutils-%DIFFUTILS_VERSION%
set DIFFUTILS_DIR=diffutils%DIFFUTILS_VERSION%

set VIEWVC_FILE=viewvc-%VIEWVC_VERSION%
set VIEWVC_DIR=viewvc%VIEWVC_VERSION%

REM choose one of following apache config files for viewvc
set VIEWVC_ALIAS=viewvc-cgi.conf
REM set VIEWVC_ALIAS=viewvc-mod_python.conf

set PATH=%PATH%;%BIN%

echo Welcome to the ViewVC Addon installer for WampServer 2.0i

REM set up the temp directory
IF NOT EXIST %TMP% GOTO MKTMP
REM FIXME: the rd command is commented out until downloading works
echo 	Temp directory found from previous install: DELETING
REM rd /S /Q %TMP%

:MKTMP
echo 	Setting up the temp directory...
mkdir %TMP%

REM download subversion archive to temp directory
REM TODO: download not functional yet

REM TODO eventually python installation will be its own addon
echo 	Installing Python...
REM installer\temp\python-2.6.msi
REM installer\temp\pywin32-214.win32-py2.6.exe
REM TODO add python to %PATH%

REM TODO eventually svn python bindings installation will be its own addon
echo 	Installing Python bindings for subversion...
unzip.exe -q %TMP%\svn-win32-1.6.6_py26.zip -d %TMP%

mkdir %TMP%\pyd
copy %TMP%\svn-win32-1.6.6\python\libsvn\*.dll %TMP%\pyd
for /R %%I in (%TMP%\pyd\*.dll) do ren "%%I" %%~nI.pyd
move %TMP%\pyd\* %TMP%\svn-win32-1.6.6\python\libsvn

move %TMP%\svn-win32-1.6.6\python\svn %PYTHON%\Lib
move %TMP%\svn-win32-1.6.6\python\libsvn %PYTHON%\Lib

REM unzip the downloaded source files and install them
REM TODO download not implemented

REM unzip the downloaded source files and install them
echo 	Extracting the files from the downloaded archive...
unzip.exe -q %TMP%\%VIEWVC_FILE%.zip -d %TMP%

REM install the viewvc files in the WampServer install directory
echo 	Running the ViewVC installer to put viewvc in the Apps directory...
python %TMP%\%VIEWVC_FILE%\viewvc-install --prefix=%WAMP%\apps\%VIEWVC_DIR% --destdir=""

REM install diffutils needed to view diffs in svn
REM FIXME should this be it's own installer? Nothing else I know of uses it
mkdir %TMP%\%DIFFUTILS_DIR%
unzip.exe -q %TMP%\%DIFFUTILS_FILE%-dep.zip bin\* -d %TMP%\%DIFFUTILS_DIR%
unzip.exe -q %TMP%\%DIFFUTILS_FILE%-bin.zip bin\* -d %TMP%\%DIFFUTILS_DIR%

mkdir %WAMP_DIFFUTILS%
move %TMP%\%DIFFUTILS_DIR% %WAMP_DIFFUTILS%

REM FIXME add diffutils to %PATH%

REM install the apache config file for ViewVC
echo 	Installing ViewVC configuration files...
copy wamp\alias\%VIEWVC_ALIAS% %TMP%
ren %TMP%\%VIEWVC_ALIAS% viewvc.conf
move %TMP%\viewvc.conf %WAMP%\alias

REM install a copy of the viewvc.conf file configured to work with WampServer
echo 	Configuring viewvc.conf to work with WampServer...
copy viewvc.conf %WAMP%\apps\%VIEWVC_DIR%

REM add python and diffutils bin directory to the PATH so apache can find them
echo 	Setting enviorment variables...
REM FIXME implement
REM licensing restrictions may prevent using xset

REM clean up temp files
echo 	Cleaning up temp files...
REM FIXME: the rd command is commented out until downloading works
REM rd /S /Q %TMP%

echo ViewVC is installed successfully. Please restart WampServer.

pause
