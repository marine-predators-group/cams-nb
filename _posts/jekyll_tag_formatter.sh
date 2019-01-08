#!/usr/bin/env bash

fileName=$1
mv "${fileName}" "${fileName}".bkp
rm "${fileName}"

header_delim="---"

count=0
while IFS= read -r line
do
  if [ "${line}" == "${header_delim}" ]
  then
    count=$( expr ${count} + 1 )
  fi
  if [ "${line}" != "${header_delim}" ] && [ ${count} -lt 2 ]
  then
    echo "${line}" | sed 's/^\-/  \-/'
  else echo "${line}"
  fi
done < "${fileName}"
