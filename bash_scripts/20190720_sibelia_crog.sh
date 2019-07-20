#!/usr/bin/bash

# Script to run Sibelia on top 21 scaffolds of C_rogercresseyi genome assembly.
# Assembly provided by Cristian Gallardo.

# Exit if any command fails
set -e

# Set working dir
wd=/home/sam/analyses

# Input/output files
assembly_fasta="${wd}/20190720_sibelia_crog/Caligus_rogercresseyi_Genome.fa"
assembly_index="${wd}/20190720_sibelia_crog/Caligus_rogercresseyi_Genome.fa.fai"
assembly_subset="${wd}/20190720_sibelia_crog/C_rogercresseyi_top_21_scaffold.fa"
sibelia_out_dir="${wd}"
system_specs="${wd}"
subset_list="${wd}/20190720_sibelia_crog/top_21_scaffold_list.txt"

# Program paths
samtools="/home/shared/samtools-1.8"
sibelia="/home/shared/Sibelia-3.0.7-Linux/bin/Sibelia"


# Capture system info
