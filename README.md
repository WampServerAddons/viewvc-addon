viewvc-addon
============

ViewVC support for WampServer

Apache version: 2.2.21

About:
 This is an addon for WampServer 2.2a that enables browsing Subversion/CVS repositories using ViewVC

Where to download ViewVC:
 Official: http://www.viewvc.org/download.html

Required Addons:
 * Python
 * Subversion
 * Subversion Language Bindings
 * DiffUtils

Optionally Required:

Manual install instructions:
 (assumes wamp is already installed and working)

 1. Install the required modules listed above
 2. download the ViewVC zip file listed above
 3. extract the files to a temporary directory
 4. inside of the folder that was extracted you should see a directory named
    viewvc-%VERSION%
 5. open a command prompt window and run the installer inside of that folder
    > python viewvc-%VERSION%\viewvc-install --prefix="c:\wamp\apps\viewvc%VERSION%" --destdir=""
 6. copy one of alias files provided to c:\wamp\alias and rename the file viewvc.conf. You may
    need to change the file paths in the alias file if you are using a different version of ViewVC.
 7. edit the viewvc.conf file in c:\wamp\apps\viewvc%VERSION% as needed, or use the provided one.
 8. restart Wamp

 * NOTE: The viewvc.conf provided is basically the one distributed with ViewVC with the root_parents
  line changed to c:\svn so it will work with the Subversion add on.

Using the Installer:
 usage: installer.bat

