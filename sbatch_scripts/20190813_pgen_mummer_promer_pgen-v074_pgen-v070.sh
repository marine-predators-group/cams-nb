#!/bin/bash
## Job Name
#SBATCH --job-name=promer_pgen074_vs_pgen070
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
#SBATCH --chdir=/gscratch/scrubbed/samwhite/outputs/20190813_pgen_mummer_promer_pgen-v074_pgen-v070

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

# Filename prefix
prefix="pgen-v074_pgen-v074"
pga1_coords="PGA_scaffold1.coords.txt"

# Program paths
promer="/gscratch/srlab/programs/MUMmer3.23/promer"
show_coords="/gscratch/srlab/programs/MUMmer3.23/show-coords"

# P.generosa Pgenerosa_v070 FastA
pgen_v070_fasta="/gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v070.fa"

# P.generosa Pgenerosa_v074 FastA
pgen_v074_fasta="/gscratch/srlab/sam/data/P_generosa/genomes/Pgenerosa_v074.fa"

### Run MUMmer (promer)
# Compares pgen_v074 (query) to pgen_v070 (reference)
"${promer}" \
-p "${prefix}" \
"${pgen_v070_fasta}" \
"${pgen_v074_fasta}"

# Parse promer delta output into more userfriendly format
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
