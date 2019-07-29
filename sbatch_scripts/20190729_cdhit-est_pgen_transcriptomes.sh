#!/bin/bash
## Job Name
#SBATCH --job-name=cdhit_pgen
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190729_cdhit-est_pgen_transcriptomes

# This script is called by 20190729_cdhit_pgen_trinity_assemblies.sh.
# That script uses rsync to transfer files to Mox via the login node.
# This is required because Mox execute nodes don't have internet access.

# Exit script if any command fails
set -e

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo "${PATH}" | tr : \\n >> system_path.log

# Set CPU threads
threads=27

# Program paths
cd-hit-est="/gscratch/srlab/programs/cd-hit-v4.8.1-2019-0228/cd-hit-est"

# Create assembly paths array
assembly_dirs_array=(
/gscratch/srlab/sam/data/P_generosa/transcriptomes/20190827_assembly
/gscratch/srlab/sam/data/P_generosa/transcriptomes/ctenidia
/gscratch/srlab/sam/data/P_generosa/transcriptomes/gonad
/gscratch/srlab/sam/data/P_generosa/transcriptomes/heart
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI115
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI116
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI123
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI124
/gscratch/srlab/sam/data/P_generosa/transcriptomes/larvae/EPI99)

# Run cd-hit-est on each assembly
for index in "${!assembly_dirs_array[@]}"
do
  # Store individual sample name by removing
  # everything up to and including the last slash in path
  sample_name=$(echo "${assembly_dirs_array[index]##*/}")
  "${cd-hit-est}" \
   # output file
  -o "${sample_name}".cdhit \
  # sequence identitiy threshold
  -c 0.98 \
  # input assembly
  -i "${assembly_dirs_array[index]}"/Trinity.fasta \
  # print alignment overlap in .clstr file
  -p 1 \
  # Use FastA defline for .clstr file names
  -d 0 \
  # set band_width of alignment
  -b 3 \
  # number of CPUs to use
  -T "${threads}"
done
