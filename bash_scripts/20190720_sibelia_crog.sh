#!/usr/bin/bash

# Script to run Sibelia on top 21 scaffolds of C_rogercresseyi genome assembly.
# Assembly provided by Cristian Gallardo.


# Set working dir
wd=/home/sam/analyses/20190720_sibelia_crog

# Input/output files
assembly_fasta="${wd}/Caligus_rogercresseyi_Genome.fa"
assembly_index="${wd}/Caligus_rogercresseyi_Genome.fa.fai"
assembly_subset="${wd}/C_rogercresseyi_top_21_scaffold.fa"
system_specs="${wd}/system_info.txt"
subset_list="${wd}/top_21_scaffold_list.txt"

# Program paths
samtools="/home/shared/samtools-1.8/samtools"
sibelia="/home/shared/Sibelia-3.0.7-Linux/bin/Sibelia"


# Record system info
echo "TODAY'S DATE:" >> "${system_specs}"
date >> "${system_specs}"
echo "------------" >> "${system_specs}"
echo "" >> "${system_specs}"
lsb_release -a >> "${system_specs}"
echo "" >> "${system_specs}"
echo "------------" >> "${system_specs}"
echo "HOSTNAME: "; hostname  >> "${system_specs}"
echo "" >> "${system_specs}"
echo "------------" >> "${system_specs}"
echo "Computer Specs:" >> "${system_specs}"
echo "" >> "${system_specs}"
lscpu >> "${system_specs}"
echo "" >> "${system_specs}"
echo "------------" >> "${system_specs}"
echo "" >> "${system_specs}"
echo "Memory Specs" >> "${system_specs}"
echo "" >> "${system_specs}"
free -mh >> "${system_specs}"

# Index FastA file
"${samtools}" faidx \
"${assembly_fasta}"

# Extract list of top 21 longest scaffolds
sort \
--numeric-sort \
--reverse \
----field-separator $'\t' \
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

# Index new FastA
"${samtools}" faidx \
"${assembly_subset}"

# Run Sibelia
"${sibelia}" \
--parameters loose \
--outdir "${wd}" \
"${assembly_subset}" \
2> sibelia_stderr.txt \
time --output sibelia_runtime.txt
