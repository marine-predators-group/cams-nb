#!/usr/bin/env bash

# Script to split MAKER GFF in to separte GFFs.

## Set MAKER GFF file location
gff=/mnt/gannet/Atumefaciens/20190109_oly_maker_functional_annotation/20181127_oly_genome_snap02.all.renamed.putative_function.domain_added.gff

## Set filename prefix.
## Output formate will be filename_prefix_feature.gff
filename_prefix=Olurida_v081

## Declare empty array
gff_array=()

## Populate array with contents of column three of MAKER GFF
gff_array=( $(awk '{ print $3 }' ${gff} | sort -u) )

## Loop over array, skipping first element - the first element is blank.
## Pass bash feature variable to awk with the "-v" declaration
## Match contents of column three in MAKER GFF with current feature
## When matched, print entire line to output file.
for feature in "${gff_array[@]}"
  do
    awk \
    -v feature="${feature}" \
    '{ if ($3 == feature) print $0 }' ${gff} \
    > ~/${filename_prefix}_${feature}.gff
done
