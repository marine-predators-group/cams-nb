#!/bin/bash

# Script to create karyotype file for Circos


# Variables
fasta_index=${HOME}/data/P_generosa/genomes/Panopea-generosa-v1.0.fa.fai
karyo_file=karyotype.pg.txt
species=pg

while IFS=$'\t' read -r line
do
	scaffold_num=$(echo "${line}" | awk -F"[_\t]" '{print $2}' | sed 's/^0//')
	scaffold_length=$(echo "${line}" | awk '{print $2}')
	printf "chr - %s\n" "${species}${scaffold_num} ${scaffold_num} 0 ${scaffold_length} chr${scaffold_num}"
done < "${fasta_index}"
