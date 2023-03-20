#!/bin/bash

declare fileName='users.db'
declare fileDir=$(pwd)
declare backupDir="$fileDir"
declare filePath="$fileDir/$fileName"

command=$1
optionalParameter=$2

function handleFileAbsence() {
  if [[ "$1" != "help" && "$1" != "" && ! -f $filePath ]]; then
    read -r -p "File $fileName does not exist. Would you like to create it? [Y/n] " answer

    if [[ "$answer" =~ ^[Yy]$ ]]; then
      touch $filePath
      echo "File $fileName is created"
    else
      echo "File $fileName must be created to continue. Try again."
      exit 1
    fi
  fi
}

function runCommand() {
  case $1 in
    add)
      add
      ;;
    find)
      find
      ;;
    backup)
      backup
      ;;
    restore)
      restore
      ;;
    list)
      listAll $2
      ;;
    '' | help)
      help
      ;;
    *)
      echo "such $1 does not exist"
      ;;
  esac
}

function validateUserInput {
  if [[ ! $1 =~ ^[A-Za-z_]+$ ]]; then
    echo "$2 must have only latin letters. Try again."
    exit 1
  fi
}

function add() {
  echo "Function should add an entry"
  read -p "Enter user name: " username
  validateUserInput $username 'User name'
    
  read -p "Enter role: " role
  validateUserInput $role 'Role'

  echo "$username, $role" | tee -a $filePath
}

function find() {
  read -p "Enter user name for search: " userName
  searchResults=`grep -i $userName $filePath`

  if [ -z "$searchResults" ]
    then
      echo "User is not found"
    else
      echo "$searchResults"
  fi
}

function backup() {
  backupFileName=`date +"%m-%d-%Y"`-$fileName.backup
  backupFilePath="$backupDir/$backupFileName"

  cp $filePath $backupFilePath

  echo "Backup for the $fileName file is created"
}
function restore() {
  latestBackupFile=$(ls $fileDir/*-$fileName.backup | tail -n 1)

  if [[ ! -f $latestBackupFile ]] 
  then 
    echo "The backup file is not found"
    exit 1
  fi

  cat $latestBackupFile > $filePath

  echo "the backup is restored from $latestBackupFile"
}

function listAll() {
  inverseParam=$1
  fileContent=`awk '{ print NR". " $0 }' < $filePath`

  if [[ $inverseParam == '--inverse' ]]
    then
      echo "$fileContent" | tail -r
    else
      echo "$fileContent"
  fi
}

function help() {
  echo -e "Manages users in db. It accepts a single parameter with a command name.\n"
  echo -e "Syntax: db.sh [command]\n"
  echo -e "List of available commands:\n"

  echo -e "add\tAdds a new line to the $fileName. Script must prompt user to type a username of new entity. \n\tAfter entering username, user must be prompted to type a role.\n"

  echo -e "backup\tCreates a new file, named 'MM-DD-YEAR-$fielname.backup' which is a copy of current $fileName\n"

  echo -e "restore\tReplaces database with its last created backup\n"

  echo -e "find\tPrompts user to type a username, then prints username and role if such exists in $fileName. \n\tIf there is no user with selected username, script must print: “User not found”. \n\tIf there is more than one user with such username, print all found entries.\n"

  echo -e "list\tPrints contents of $fileName in format: 'N. username, role'\n\twhere N – a line number of an actual record accepts.\n\tAdditional optional parameters: \n\t--inverse - which allows to get result in an opposite order – from bottom to top\n"

  echo -e "help\tProvides list of all available commands\n"
}

handleFileAbsence
runCommand $command $optionalParameter

    