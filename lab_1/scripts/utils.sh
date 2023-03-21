#!/bin/bash

compressBuild() {
  local archivedFilePath="$1"
  local buildDir="$2"

  zip -rj $archivedFilePath $buildDir
}

deleteExistedFile() {
  if [[ -f "$1" ]]; then
    rm "$1"
  fi
}

deleteExistedFolderFully() {
  if [[ -d "$1" ]]; then
    rm -rf "$1"
  fi
}

function checkJobPassingSuccessfully {
  operation=$2
  if [[ $1 == 0 ]]; then
    echo -e '\nOperation '$operation' is finished successfully'
  else
    echo -e "\nERROR: Operation '$operation' has been failed"
    exit 0
  fi
}