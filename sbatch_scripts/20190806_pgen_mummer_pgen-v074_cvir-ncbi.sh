#!/bin/bash
## Job Name
#SBATCH --job-name=mummer_pgen074
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=5-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190806_pgen_mummer_pgen-v074_cvir-ncbi

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
prefix="pgen-v074_cvir-ncbi"

# Program paths
nucmer="/gscratch/srlab/programs/mummer-4.0.0beta2/nucmer"

# C.virginica NCBI FastA
cvir_fasta="/gscratch/srlab/sam/data/C_virginica/genomes/GCF_002022765.2_C_virginica-3.0/GCF_002022765.2_C_virginica-3.0_genomic.fa"

# P.generosa Pgenerosa_v074 FastA
pgen_v074_fasta="/gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v074.fa"

### Run MUMmer (nucmer)
# Compares pgen_v074 (query) to cvir-ncbi (reference)
"${nucmer}" \
"${cvir_fasta}" \
"${pgen_v074_fasta}" \
--prefix="${prefix}" \
--threads="${threads}"
