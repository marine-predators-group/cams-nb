#!/usr/bin/env bash

counter=0
code_tag="false"
while read -r line
do
  code_tag="false"
  if grep "<code>" <<< "${line}" || grep "</code>" <<< "${line}"
  then
    (( counter++ ))
    code_tag="true"
  fi
  echo "----------------"
  echo "COUNTER IS: ${counter}"
  echo "CODE TAG IS: ${code_tag}"
  echo "----------------"
  if [ "${counter}" -eq 0 ] || [ "${counter}" -eq 2 ] && [ "${code_tag}" == "false" ]
  then
    echo "${line}"
  elif [ "${counter}" -eq 1 ] && [ "${code_tag}" == "false" ]
  then
    echo "    ${line}"
  fi
done< 2019-04-16-Metagenomics-Gene-Prediction---P.generosa-Water-Samples-Using-MetaGeneMark-on-Mox-to-Compare-pH-Treatments.md
