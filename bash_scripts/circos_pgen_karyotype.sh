#!/bin/bash

# Script to create karyotype file for Circos


# Variables
fasta_index=${HOME}/data/P_generosa/genomes/Panopea-generosa-v1.0.fa.fai
karyo_file=karyotype.pg.txt
species=pg

while read -r line
do
	awk -v var="${species}" '{print $1}' "${line}"
done <<< "${fasta_index}"
