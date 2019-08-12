---
layout: post
title: Genome Comparison - Pgenerosa_v074 vs Pgenerosa_v074 with MUMmer on Mox
date: '2019-08-07 21:12'
tags:
  - Panopea generosa
  - geoduck
  - Pgenerosa_v074
  - v074:MUMmer
  - mox
categories:
  - Miscellaneous
---
In continuing to further improve our geoduck genome annotation, I'm attempting to figure out why [Scaffold 1 of our assembly doesn't have any annotations](https://github.com/RobertsLab/resources/issues/721). As part of that I've decided to perform a series of genome comparisons and see how they match up, with an emphasis on Scaffold 1, using [MUMmer (v4)](https://github.com/mummer4/mummer) (specifically, `nucmer` for nucleotide comparisons). This software is specifically designed to do this type of comparison.

Basically, MUMmer will take a query genome assembly (Pgenerosa_v074 in this case), align it to a reference genome, and determine contig similarities/differences. So, this should provide further insight on what is happening in Pgenerosa_v074 Scaffold 1, when compared to related (or different) species' genomes.

To serve as a "positive control", I'll align the Pgenerosa_v074 assembly to itself.

INPUT FILES:

Query:

- [Pgenerosa_v074.fa](http://owl.fish.washington.edu/halfshell/genomic-databank/Pgenerosa_v074.fa)

Reference genome (_Panopea generosa_ - Pacific geoduck):

- [Pgenerosa_v074.fa](http://owl.fish.washington.edu/halfshell/genomic-databank/Pgenerosa_v074.fa)


This was run using MUMmer v4 on Mox using the SBATCH script below.

SBATCH script (GitHub):

- [20190807_pgen_mummer_pgen-v074_pgen-v074.sh](https://github.com/RobertsLab/sams-notebook/blob/master/sbatch_scripts/20190807_pgen_mummer_pgen-v074_pgen-v074.sh)

```shell
#!/bin/bash
## Job Name
#SBATCH --job-name=mummer_pgen074_pgen074
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=4-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190807_pgen_mummer_pgen-v074_pgen-v074

# Exit if any command fails
set -e

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Load Open MPI module for parallel, multi-node processing

module load icc_19-ompi_3.1.2

# SegFault fix?
export THREADS_DAEMON_MODEL=1

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo "${PATH}" | tr : \\n >> system_path.log

### Set variables
# CPUs to use
threads=28

# Filename prefix
prefix="pgen-v074_pgen-v074"
pga1_coords="PGA_scaffold1.coords.txt"

# Program paths
nucmer="/gscratch/srlab/programs/mummer-4.0.0beta2/nucmer"
show_coords="/gscratch/srlab/programs/mummer-4.0.0beta2/show-coords"

# P.generosa Pgenerosa_v074 FastA
pgen_v074_fasta="/gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v074.fa"

### Run MUMmer (nucmer)
# Compares pgen_v074 (query) to sglo-ncbi (reference)
"${nucmer}" \
--prefix="${prefix}" \
--threads="${threads}" \
"${pgen_v074_fasta}" \
"${pgen_v074_fasta}"

# Parse nucmer delta output into more userfriendly format
# -b useful for syteny - merges overlapping alignments
# -c show percent coverage info
# -q option sorts by query
"${show_coords}" \
-b \
-c \
-q \
"${prefix}".delta \
> "${prefix}".coords.txt

# Parse out PGA_scaffold1__77_contigs__length_89643857
head -n 5 "${prefix}".coords.txt > "${pga1_coords}"
grep "PGA_scaffold1__77_contigs__length_89643857" "${prefix}".coords.txt >> "${pga1_coords}"
```


---

#### RESULTS

Output folder:

- []()



I'm currently exploring some options for visualizing this data:

- [Dot](https://github.com/dnanexus/dot): This is the current forerunner, due to simplicity and ease of understanding. Will probably be the fastest way to get some sort of information about these genome comparisons.

- [CIRCOS](http://circos.ca/): This is _very_ cool and designed for just this type of analysis. However, seems like the learning curve might be a bit steep (i.e. time consuming). I'll probably play around with this at some point.

- [MUMmerplots with ggplot2](https://jmonlong.github.io/Hippocamplus/2017/09/19/mummerplots-with-ggplot2/): Uses R to reproduce the dotplots that can be generated with MUMmer. I've messed with this and, although easy to plug my data in to, the results seems to be confusing. May need more time with it, though.
