#!/bin/sh

if [ -e ./HPhi ]; then
  ./HPhi $@
else
  which HPhi > /dev/null 2>/dev/null
  if [ $? == 0 ]; then
    HPhi $@
  else
    scriptdir=$(cd $(dirname $0); pwd)
    cat << EOF
HPhi is not found.
Make a symbolic link "${scriptdir}/HPhi" pointing to HPhi executable
or add the directory where HPhi exists to \$PATH.
EOF
  fi
fi
