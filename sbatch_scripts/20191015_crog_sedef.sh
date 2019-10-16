#!/bin/bash
## Job Name
#SBATCH --job-name=sedef
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=20-00:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/samwhite/outputs/20191015_crog_sedef



# Set working dir
wd=$(pwd)


# Input/output files
softmasked_assembly_fasta="${wd}/C_rogercresseyi_top_21_scaffold.fa.masked"

# Program paths
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
sedef="/gscratch/srlab/programs/sedef/sedef.sh"


# Record system info
{
date
echo ""
echo "System PATH for $SLURM_JOB_ID"
echo ""
printf "%0.s-" {1..10}
echo "${PATH}" | tr : \\n
} >> system_path.log


# Run SEDEF
