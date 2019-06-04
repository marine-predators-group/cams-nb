#!/bin/bash

## Script to append sample-specific headers to each ID_CpG
## file and join all ID_CpG files.

## Run file from within this directory.

# Temp file placeholder
tmp=$(mktemp)

# Create array of subdirectories.
array=(*/)

# Create column headers for ID_CpG files using sample name from directory name.
# Expects directory names like this:
# Combined.SNP.TRSdp5g95FnDNAmaf05.sorted.ANACfill.HC_VA_3_GENE_analysis
# Command will remove the "_GENE_analysis" portion.
for file in "${array[@]}"
do
  gene=$(echo "${file}" \
  | awk -F[.] '{print $6}' \
  | rev \
  | cut -d "_" -f3- \
  | rev)
  sed "1iID\t${gene}" "${file}"ID_CpG \
  > "${file}"ID_CpG_labelled
done

# Create initial file for joining
cp "${array[0]}"ID_CpG_labelled ID_CpG_labelled_all

# Loop through array and performs joins.
# Looping starts at array index 1, since index 0 was processed above.
# Assumes input files were already sorted by chromosome, in column 1.
# Outputs
for file in "${array[@]:1}"
do
  join \
  --nocheck-order \
  ID_CpG_labelled_all "${file}"ID_CpG_labelled \
  | column -t -s "$(printf '\t')" \
  > "${tmp}" \
  && mv "${tmp}" ID_CpG_labelled_all
done
