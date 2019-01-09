#!/usr/bin/env bash

gff=/mnt/gannet/Atumefaciens/20190109_oly_maker_functional_annotation/20181127_oly_genome_snap02.all.renamed.putative_function.domain_added.gff

gff_array=()
gff_array=( $(awk '{ print $3 }' ${gff} | sort -u) )

for feature in "${gff_array[@]:1}"
  do
    echo "${feature}"
    awk \
    -v feature="${feature}" \
    '{ if ($3 == feature) print $0 }' ${gff} \
    > ~/Olurida_v11_${feature}.gff
done
