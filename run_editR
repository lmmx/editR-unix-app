#!/usr/bin/env bash

editR_SCR_FILENAME="editR_chrome_app.R"
# Path to this script:
SELF_SCR_PATH=$(readlink -f "$0")
# Path to the R script calling editR:
editR_LAUNCHER=$(dirname "$SELF_SCR_PATH")/$editR_SCR_FILENAME

# If a (single) arg given, use as filename
# If zero or >1 args, resort to file selection dialog
if [ $# -eq 1 ]; then
  editR_file=$1
else
  editR_file=$(zenity --file-selection)
fi

Rscript "$editR_LAUNCHER" $editR_file
