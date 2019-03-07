#!/bin/bash
## Job Name
#SBATCH --job-name=20180912_bismark
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=30-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/20180912_oly_WGBSseq_bismark

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log


# Directories and programs

bismark_dir="/gscratch/srlab/programs/Bismark-0.19.0"
trimmed="/gscratch/scrubbed/samwhite/data/O_lurida/BSseq/whole_genome_BSseq_reads/20180830_trimgalore"
bowtie2_dir="/gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64/"
genome="/gscratch/scrubbed/samwhite/data/O_lurida/BSseq/20180503_oly_genome_pbjelly_sjw_01_bismark/"
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"

# Run bismark using bisulftie-converted genome
# Converted genome from 20180503 - by me:
# http://onsnetwork.org/kubu4/2018/05/08/bs-seq-mapping-olympia-oyster-bisulfite-sequencing-trimgalore-fastqc-bismark/

${bismark_dir}/bismark \
--path_to_bowtie ${bowtie2_dir} \
--genome ${genome} \
-p 28 \
--non_directional \
${trimmed}/1_ATCACG_L001_R1_001_trimmed.fq.gz \
${trimmed}/2_CGATGT_L001_R1_001_trimmed.fq.gz \
${trimmed}/3_TTAGGC_L001_R1_001_trimmed.fq.gz \
${trimmed}/4_TGACCA_L001_R1_001_trimmed.fq.gz \
${trimmed}/5_ACAGTG_L001_R1_001_trimmed.fq.gz \
${trimmed}/6_GCCAAT_L001_R1_001_trimmed.fq.gz \
${trimmed}/7_CAGATC_L001_R1_001_trimmed.fq.gz \
${trimmed}/8_ACTTGA_L001_R1_001_trimmed.fq.gz

# Deduplicate bam files

${bismark_dir}/deduplicate_bismark \
--bam \
--single \
*.bam

# Methylation extraction

${bismark_dir}/bismark_methylation_extractor \
--bedgraph \
--counts \
--scaffolds \
--remove_spaces \
--multicore 28 \
--buffer_size 75% \
*deduplicated.bam

# Bismark processing report

${bismark_dir}/bismark2report

#Bismark summary report

${bismark_dir}/bismark2summary

# Sort files for methylkit and IGV

find *deduplicated.bam | \
xargs basename -s .bam | \
xargs -I{} ${samtools} \
sort --threads 28 {}.bam \
-o {}.sorted.bam

# Index sorted files for IGV
# The "-@ 16" below specifies number of CPU threads to use.

find *.sorted.bam | \
xargs basename -s .sorted.bam | \
xargs -I{} ${samtools} \
index -@ 28 {}.sorted.bam

