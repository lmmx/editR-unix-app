# editR-unix-app

R script and wrapper shell script (_Bash_) to run [editR](https://github.com/swarm-lab/editR) in app mode on Linux (rather than a new browser tab). Either provide a filename on the command line, or run without an argument to use the file selection dialog (uses [Zenity](https://help.gnome.org/users/zenity/stable/) for Linux/BSD).

## Setup

Add `export PATH=$PATH:/path/to/editR-unix-app/run_editR` to your .bashrc. This will add a command `run_editR` on the command line.

Alternatively, create a symlink to `run_editR` in a location already exported to the PATH (_e.g._, for me, `~/opt/bin/`) and possibly renaming it for convenience (_e.g._ as `editr`):

* (Assuming `export PATH=$PATH:~/opt/bin` is in the .bashrc)
* `ln -s /path/to/editR-unix-app/run_editR ~/opt/bin/editr`

## To do

* Create a .desktop file + icon set for launcher
