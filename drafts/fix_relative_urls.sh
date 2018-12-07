#!/usr/bin/env bash

for file in *.m*
do
  matches=($(grep -o '\]([0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9]/' "${file}"))
  for match in ${matches[@]}
    do
    mod_match_no_brackets=$(echo "${match}" | sed 's_\](__g')
    mod_match_no_slahes=$(echo "${mod_match_no_brackets}" | sed 's_/_-_g')
    sed -i.bak "\_${match}_ s%${match}%\](https://robertslab.github.io/sams-notebook/${mod_match_no_slahes}%g" ${file}
  done
done
