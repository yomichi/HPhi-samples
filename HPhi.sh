#!/bin/sh

scriptdir=$(cd $(dirname $0); pwd)

if [ -e ${scriptdir}/HPhi ]; then
  ${scriptdir}/HPhi $@
else
  which HPhi > /dev/null 2>/dev/null
  if [ $? == 0 ]; then
    HPhi $@
  else
    cat << EOF
HPhi is not found.
Make a symbolic link "${scriptdir}/HPhi" pointing to HPhi executable
or add the directory where HPhi exists to \$PATH.
EOF
  fi
fi
