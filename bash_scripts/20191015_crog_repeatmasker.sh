#!/usr/bin/bash

# Script to subset top 21 scaffolds of C_rogercresseyi genome assembly,
# and create a soft-masked (lowercase repeats) FastA for use with SEDEF.
# Assembly provided by Cristian Gallardo.


# Set CPUs
cpus=16

# Input/output files
assembly_fasta="Caligus_rogercresseyi_Genome.fa"
assembly_index="Caligus_rogercresseyi_Genome.fa.fai"
assembly_subset="C_rogercresseyi_top_21_scaffold.fa"
system_specs="system_info.txt"
subset_list="top_21_scaffold_list.txt"

# Program paths
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
repeatmasker=""


# Record system info
{
echo "TODAY'S DATE:"
date
echo "------------"
echo ""
lsb_release -a
echo ""
echo "------------"
echo "HOSTNAME: " hostname
echo ""
echo "------------"
echo "Computer Specs:"
echo ""
lscpu
echo ""
echo "------------"
echo ""
echo "Memory Specs"
echo ""
free -mh
} >> "${system_specs}"


# Index assembly FastA file
"${samtools}" faidx \
"${assembly_fasta}"

# Extract list of top 21 longest scaffolds
sort \
--numeric-sort \
--reverse \
--field-separator $'\t' \
--key 2,2 \
"${assembly_index}" \
| head -n 21 \
| awk -F'\t' '{print $1}' \
> "${subset_list}"

# Create FastA of longest 21 scaffolds
xargs \
"${samtools}" faidx \
"${assembly_fasta}" \
< "${subset_list}" \
> "${assembly_subset}"
