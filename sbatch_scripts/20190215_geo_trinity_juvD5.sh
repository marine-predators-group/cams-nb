#!/bin/bash
## Job Name
#SBATCH --job-name=trinity_20190215
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=2
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=5-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190215_trinity_geoduck_juvD5_RNAseq

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log

data_dir=${data_dir}
trinity_dir=/gscratch/srlab/programs/trinityrnaseq-Trinity-v2.8.3
assembly_stats=assembly_stats.txt

# Run Trinity
${trinity_dir}/Trinity \
--trimmomatic \
--seqType fq \
--max_memory 120G \
--CPU 56 \
--left \
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-1_S8_L001_R1_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-2_S16_L002_R1_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-3_S24_L003_R1_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-4_S32_L004_R1_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-5_S40_L005_R1_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-6_S48_L006_R1_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-7_S56_L007_R1_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-8_S64_L008_R1_001.fastq.gz \
--right \
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-1_S8_L001_R2_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-2_S16_L002_R2_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-3_S24_L003_R2_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-4_S32_L004_R2_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-5_S40_L005_R2_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-6_S48_L006_R2_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-7_S56_L007_R2_001.fastq.gz,\
${data_dir}/Geoduck-larvae-day5-RNA-EPI-99-8_S64_L008_R2_001.fastq.gz

# Assembly stats
${trinity_dir}/util/TrinityStats.pl Trinity.fasta \
> ${assembly_stats}
