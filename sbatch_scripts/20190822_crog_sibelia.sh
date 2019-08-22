#!/bin/bash
## Job Name
#SBATCH --job-name=sibelia
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## CPU request
#SBATCH --constraint="skylake"
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=30-00:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/samwhite/outputs/20190822_crog_sibelia



# Set working dir
wd=$(pwd)


# Input/output files
assembly_fasta="/gscratch/srlab/sam/data/C_rogercresseyi/genomes/Caligus_rogercresseyi_Genome.fa"
assembly_index="${wd}/Caligus_rogercresseyi_Genome.fa.fai"
assembly_subset="${wd}/C_rogercresseyi_top_21_scaffold.fa"
system_specs="${wd}/system_info.txt"
subset_list="${wd}/top_21_scaffold_list.txt"

# Program paths
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
sibelia="/gscratch/srlab/programs/Sibelia-3.0.7-Source/Sibelia"


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

# Index FastA file
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

# Index new FastA
"${samtools}" faidx \
"${assembly_subset}"

# Run Sibelia
"${sibelia}" \
--parameters loose \
--outdir "${wd}" \
"${assembly_subset}" \
2> sibelia_stderr.txt
