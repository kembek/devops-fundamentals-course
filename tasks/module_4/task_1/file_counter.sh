# !/bin/bash

dir=$1

if [ ! -d "$dir" ] ; then
  echo "The directory: '$dir' does not exist"
else
  files=`find $dir -type f 2> /dev/null | wc -l | xargs`
  echo "Count of files: $files in $dir"
fi

