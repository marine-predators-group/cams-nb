#!/bin/bash
## Job Name
#SBATCH --job-name=20180829_trinity
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/20190215_trinity_geoduck_ctenidia_RNAseq

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log

data_dir=/gscratch/scrubbed/samwhite/data/P_generosa/RNAseq

# Run Trinity
/gscratch/srlab/programs/trinityrnaseq-Trinity-v2.8.3/Trinity \
--trimmomatic \
--seqType fq \
--max_memory 120G \
--CPU 28 \
--left \
${data_dir}/Geoduck-ctenidia-RNA-1_S3_L001_R1_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-2_S11_L002_R1_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-3_S19_L003_R1_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-4_S27_L004_R1_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-5_S35_L005_R1_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-6_S43_L006_R1_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-7_S51_L007_R1_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-8_S59_L008_R1_001.fastq.gz,\
--right \
${data_dir}/Geoduck-ctenidia-RNA-1_S3_L001_R2_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-2_S11_L002_R2_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-3_S19_L003_R2_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-4_S27_L004_R2_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-5_S35_L005_R2_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-6_S43_L006_R2_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-7_S51_L007_R2_001.fastq.gz,\
${data_dir}/Geoduck-ctenidia-RNA-8_S59_L008_R2_001.fastq.gz,\
