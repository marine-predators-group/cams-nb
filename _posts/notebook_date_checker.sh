#!/bin/bash env

for file in *.m*
do
  internal_date=$(grep -o "date: [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]" ${file} | awk '{print $2}')
  filename_date=$(echo ${file:0:10})
  #echo "Checking file ${file}"
  #echo "Internal date is: ${internal_date}"
  #echo "Filename date is: ${filename_date}"
  #echo "---------"
  if [ "${internal_date}" != "${filename_date}" ]; then
    echo "Dates don't match in file ${file}"
  fi
done
