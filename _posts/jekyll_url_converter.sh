#!/usr/bin/env bash

# Take input file and assing to variable
fileName=$1

# Use grep to capture full URL in array, in case multiple links in a file.
declare -a old_url=()

old_url=($(grep -o '(http://onsnetwork.org/kubu4/[^)]*/)' "${fileName}"))


# Iterate through array to reformat old URLs to new repo relative paths
# and edit file "in place" with sed.
for url in "${old_url[@]}"
do
  new_format=$(echo ${url: 29:-2})
  new_link="(${new_format}.html)"
  sed -i.old "s~${url}~${new_link}~g" "${fileName}"
done
