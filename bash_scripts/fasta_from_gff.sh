#!/bin/env bash

# Script to extract FastA sequences from GFF3 (specifically, those produced by MAKER)

# User needs to set GFF path and desired output file name
#-----------------------------------
# Set path to GFF
gff=

# Set path to desired FastA file output
fasta_out=

#-----------------------------------

# Determine total number of lines (records) in GFF
total_records=$(wc -l < ${gff})

# Determine line number of FastA demarcation
fasta_id_line=$(grep -n "##FASTA" ${gff} cut -d":" -f1)

# Add "1" to the fasta_id_line to establish starting line of first FastA record
begin_fastas_line=$(( ${fasta_id_line + 1 }))

# Print all lines from beginning of FastA records to the end of the file
awk 'BEGIN{min=${begin_fastas_line};max=total_records} \
{if (NR>=min) {if (NR<=max) print}}' ${gff} \
> ${fasta_out}
