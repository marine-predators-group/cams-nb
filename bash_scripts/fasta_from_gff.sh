#!/bin/env bash


total_records=$(wc -l < ${gff})

fasta_id_line=$(grep -n "##FASTA" ${gff} cut -d":" -f1)


begin_fastas_line=$(( ${fasta_id_line + 1 }))


awk 'BEGIN{min=${begin_fastas_line};max=total_records} \
{if (NR>=min) {if (NR<=max) print}}' ${gff} \
> ${fasta_out}
