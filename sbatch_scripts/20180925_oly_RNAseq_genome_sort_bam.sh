#!/bin/bash
## Job Name
#SBATCH --job-name=20180925_oly_sort
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

# Set hisat2 basename
hisat2_basename=Olurida_v081

## samtools
stools=/gscratch/srlab/programs/samtools-1.9/samtools

# Sort BAM

"${stools}" sort \
--threads 28 \
20180925_"${hisat2_basename}".bam \
-o 20180925_"${hisat2_basename}".sorted.bam

# Index for use in IGV
##-@ specifies thread count; --thread option not available in samtools index
"${stools}" index \
-@ 28 \
20180925_"${hisat2_basename}".sorted.bam

