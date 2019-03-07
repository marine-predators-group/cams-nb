#!/bin/bash
## Job Name
#SBATCH --job-name=20180925_oly_hisat2
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/20180925_oly_RNAseq_genome_hisat2

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log


# Set genome assembly path
oly_genome_path=/gscratch/srlab/sam/data/O_lurida/oly_genome_assemblies

# Set hisat2 basename
hisat2_basename=Olurida_v081

# Set program paths
## hisat2
hisat2=/gscratch/srlab/programs/hisat2-2.1.0

## samtools
stools=/gscratch/srlab/programs/samtools-1.9/samtools

# Build hisat2 genome index
${hisat2}/hisat2-build \
-f ${oly_genome_path}/Olurida_v081.fa \
Olurida_v081 \
-p 28

# Align reads to oly genome assembly
${hisat2}/hisat2 \
--threads 28 \
-x "${hisat2_basename}" \
-q \
-1 /gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-15_S7_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-15_S7_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-16_S8_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-16_S8_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-17_S9_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-17_S9_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-18_S10_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-18_S10_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-1_S1_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-1_S1_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-2_S2_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-2_S2_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-3_S3_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-3_S3_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-4_S4_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-4_S4_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-4Spl_S11_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-4Spl_S11_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-5_S5_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-5_S5_L004_R1_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-6_S6_L004_R1_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-6_S6_L004_R1_0348.fastq.gz \
-2 \
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-15_S7_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-15_S7_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-16_S8_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-16_S8_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-17_S9_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-17_S9_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-18_S10_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-18_S10_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-1_S1_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-1_S1_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-2_S2_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-2_S2_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-3_S3_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-3_S3_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-4_S4_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-4_S4_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-4Spl_S11_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-4Spl_S11_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-5_S5_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-5_S5_L004_R2_0348.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-6_S6_L004_R2_0343.fastq.gz,\
/gscratch/scrubbed/samwhite/data/O_lurida/RNAseq/CP-6_S6_L004_R2_0348.fastq.gz \
-S 20180925_"${hisat2_basename}".sam

# Convert SAM file to BAM
"${stools}" view \
--threads 28 \
-b 20180925_"${hisat2_basename}".sam > 20180925_"${hisat2_basename}".bam

# Sort BAM
"${stools}" sort \
--threads 28 \
20180919_"${hisat2_basename}".bam \
-o 20180925_"${hisat2_basename}".sorted.bam

# Index for use in IGV
##-@ specifies thread count; --thread option not available in samtools index
"${stools}" index \
-@ 28 \
20180925_"${hisat2_basename}".sorted.bam

