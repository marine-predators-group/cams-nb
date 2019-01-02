---
layout: post
title: Metagenome Assembly - P.generosa Water Sample Trimmed HiSeqX Data Using Megahit on Mox
date: '2019-01-02 14:26'
tags:
  - Panopea generosa
  - geoduck
  - megahit
  - mox
  - metagenome
  - assembly
categories:
  - Miscellaneous
---
Attempting an assembly of our geoduck metagenomics HiSeqX data using [Megahit (v.1.1.4)](https://github.com/voutcn/megahit) on a Mox node.

Assembly was run using default settings.

Assembly coverage was assessed using the following [BBmap (v.38.34) scripts](https://sourceforge.net/projects/bbmap/):

- ```bbwrap.sh``` (alignments)

- ```pileup.sh``` (coverage)


SBATCH script is linked here and pasted in full below:

- [20190102_metagenomics_geo_megahit/20190102_metagenomics_geo_megahit.sh](http://gannet.fish.washington.edu/Atumefaciens/20190102_metagenomics_geo_megahit/20190102_metagenomics_geo_megahit.sh)

<pre><code>
#!/bin/bash
## Job Name
#SBATCH --job-name=megahit
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=5-00:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190102_metagenomics_geo_megahit

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
echo ${PATH} | tr : \\n >> system_path.log


# variables
fastq_dir=/gscratch/srlab/sam/data/metagenomics/P_generosa
megahit=/gscratch/srlab/programs/megahit_v1.1.4_LINUX_CPUONLY_x86_64-bin/megahit
bbmap_dir=/gscratch/srlab/programs/bbmap_38.34

## Inititalize arrays
fastq_array_R1=()
fastq_array_R2=()

# Create array of fastq R1 files
for fastq in ${fastq_dir}/*R1*.gz; do
  fastq_array_R1+=(${fastq})
done

# Create array of fastq R2 files
for fastq in ${fastq_dir}/*R2*.gz; do
  fastq_array_R2+=(${fastq})
done

# Create comma-separated list of input files
R1_fastq_list=$(IFS=,; echo "${fastq_array_R1[*]}")
R2_fastq_list=$(IFS=,; echo "${fastq_array_R2[*]}")


# Run Megahit using paired-end reads
${megahit} \
-1 ${R1_fastq_list} \
-2 ${R2_fastq_list} \
--num-cpu-threads 28

# Determine coverage
## Align reads with BBmap BBwrap
${bbmap_dir}/bbwrap.sh \
ref=megahit_out/final.contigs.fa \
in1=${R1_fastq_list} \
in2=${R2_fastq_list} \
out=aln.sam.gz

## Output contig coverage
${bbmap_dir}/pileup.sh \
in=aln.sam.gz \
out=coverage.txt
</code></pre>
