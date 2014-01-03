Android tools for automation enthusiasts and lazy people
========================================================

0. Prerequisites
----------------

- Set ANDROID_HOME system variable pointing to your SDK


1. Rake tasks
-------------

(Mac, possibly Linux)

These allow for easy spinning up and killing the android emulator for continuous integration purposes.

Setup:

- Set the AVD_NAME to whatever your android emulator name is
- run with rake --rakefile emulator_start or emulator_kill commands

2. Right-click APK installation in Finder
-----------------------------------------

(Mac only)

Name says it all, just install the workflow and you should find it in Finder's Services menu.

Setup:

- Have your build-tools/{YOUR_ANDROID_VERSION} in PATH. (uses the aapt command)
- Right click on any apk with device connected to install. Will reinstall if the app already exists.











