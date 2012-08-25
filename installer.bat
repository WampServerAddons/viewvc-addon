@echo OFF
REM TODO use the call command to set some variables common to both the installer/uninstaller
REM Requires the python, diffutils, subversion, subversion lang bindings
set VIEWVC_VERSION=1.1.11
set APACHE_VERSION=2.2.21
set WAMP_VERSION=2.2a

set ADDON=ViewVC

set BIN=installer\bin
set TMP=installer\temp

set WAMP=c:\wamp
set WAMP_VIEWVC=%WAMP%\apps\viewvc%VIEWVC_VERSION%

set VIEWVC_FILE=viewvc-%VIEWVC_VERSION%
set VIEWVC_DIR=viewvc%VIEWVC_VERSION%

set VIEWVC_DOWNLOAD=http://www.viewvc.org/%VIEWVC_FILE%.zip

REM choose one of following apache config files for ViewVC
set VIEWVC_ALIAS=viewvc-cgi.conf
REM set VIEWVC_ALIAS=viewvc-mod_wsgi.conf
REM set VIEWVC_ALIAS=viewvc-mod_python.conf

set PATH=%PATH%;%BIN%

echo Welcome to the %ADDON% Addon installer for WampServer %WAMP_VERSION%

REM set up the temp directory
IF NOT EXIST %TMP% GOTO MKTMP
echo 	Temp directory found from previous install: DELETING
rd /S /Q %TMP%

:MKTMP
echo 	Setting up the temp directory...
mkdir %TMP%

REM download ViewVC archive to temp directory
echo 	Downloading %ADDON% binaries to temp directory...
wget.exe -nd -q -P %TMP% %VIEWVC_DOWNLOAD%
if not %ERRORLEVEL%==0 (echo FAIL: could not download %ADDON% binaries& pause& exit 1)

REM unzip the downloaded source files and install them
echo 	Extracting the files from the downloaded archive...
unzip.exe -q %TMP%\%VIEWVC_FILE%.zip -d %TMP%
if not %ERRORLEVEL%==0 (echo FAIL: could not extract %ADDON% binaries& pause& exit 1)

REM install the ViewVC files in the WampServer install directory
echo 	Running the ViewVC installer to put ViewVC in the Apps directory...
python %TMP%\%VIEWVC_FILE%\viewvc-install --prefix=%WAMP_VIEWVC% --destdir=""  > NUL 2>&1
if not %ERRORLEVEL%==0 (echo FAIL: could not install %ADDON% binaries& pause& exit 1)

REM install the apache config file for ViewVC
echo 	Installing %ADDON% configuration files...
copy wamp\alias\%VIEWVC_ALIAS% %WAMP%\alias\viewvc.conf
if not %ERRORLEVEL%==0 (echo FAIL: could not move configuration files& pause& exit 1)

REM install a copy of the viewvc.conf file configured to work with WampServer
echo 	Configuring viewvc.conf to work with WampServer...
copy viewvc.conf %WAMP_VIEWVC%
if not %ERRORLEVEL%==0 (echo FAIL: could not move configuration files& pause& exit 1)

REM clean up temp files
echo 	Cleaning up temp files...
rd /S /Q %TMP%

echo %ADDON% is installed successfully. Please restart WampServer.

pause
