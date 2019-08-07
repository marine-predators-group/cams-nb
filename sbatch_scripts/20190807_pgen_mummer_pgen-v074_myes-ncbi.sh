#!/bin/bash
## Job Name
#SBATCH --job-name=mummer_pgen074_myes-ncbi
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190807_pgen_mummer_pgen-v074_myes-ncbi

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
prefix="pgen-v074_myes-ncbi"
pga1_coords="PGA_scaffold1.coords.txt"

# Program paths
nucmer="/gscratch/srlab/programs/mummer-4.0.0beta2/nucmer"
show_coords="/gscratch/srlab/programs/mummer-4.0.0beta2/show-coords"

# M.yessoensis NCBI FastA
myes_fasta="/gscratch/srlab/sam/data/M_yessoensis/genomes/
GCA_002113885.2_ASM211388v2_genomic.fna"

# P.generosa Pgenerosa_v074 FastA
pgen_v074_fasta="/gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v074.fa"

### Run MUMmer (nucmer)
# Compares pgen_v074 (query) to myes-ncbi (reference)
"${nucmer}" \
--prefix="${prefix}" \
--threads="${threads}" \
"${myes_fasta}" \
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
