#!/bin/bash
## Job Name
#SBATCH --job-name=reago_metagenomics
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=25-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190613_metagenomics_pgen_reago

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

wd=$(pwd)
threads=28

# Paths to programs
reago_dir="/gscratch/srlab/programs/reago-1.1-release-2015.12.18"
reago="${reago_dir}/reago.py"
reago_filter="${reago_dir}/filter_input.py"
cm_dir="${reago_dir}/cm"
cm_to_use="${cm_dir}/ab"
seqtk="/gscratch/srlab/programs/seqtk-1.3/seqtk"

# Input files
fastq_dir="/gscratch/srlab/sam/data/metagenomics/P_generosa/"


## Inititalize arrays
fastq_array_R1=()
fastq_array_R2=()
fasta_array_R1=()
fasta_array_R2=()
names_array=()

# Create array of fastq R1 files
for fastq in ${fastq_dir}/*R1*.gz
do
  fastq_array_R1+=(${fastq})
done

# Create array of fastq R2 files
for fastq in ${fastq_dir}/*R2*.gz
do
  fastq_array_R2+=(${fastq})
done

# Create array of sample names
## Uses parameter substitution to strip leading path from filename
## Uses awk to parse out sample name from filename
for R1_fastq in ${fastq_dir}/*R1*.gz
do
  names_array+=($(echo ${R1_fastq#${fastq_dir}} | awk -F"_" '{print $3 $4}'))
done

# Create list of fastq files used in analysis
## Uses parameter substitution to strip leading path from filename
for fastq in ${fastq_dir}*.gz
do
  echo "${fastq#${fastq_dir}}" >> fastq.list.txt
done

# Concatenate paired-end reads into singular FastA files for each sample.
# Uses seqtk to convert FastQ to FastA.
for index in "${!fastq_array_R1[@]}"
do
  sample_name=$(echo "${names_array[index]}")
  if [ "${sample_name}" == "MG1" ] \
  || [ "${sample_name}" == "MG2" ] \
  || [ "${sample_name}" == "MG5" ]
  then
    sample_name="${sample_name}"_pH82
  else
    sample_name="${sample_name}"_pH71
  fi
  "${seqtk}" seq -a "${fastq_array_R1[index]}" >> "${sample_name}"_R1.fasta
  fasta_array_R1+=("${sample_name}"_R1.fasta)
  "${seqtk}" seq -a  "${fastq_array_R2[index]}" >> "${sample_name}"_R2.fasta
  fasta_array_R2+=("${sample_name}"_R2.fasta)
done

# Run reago filterinput.py on each FastA pair
for index in "${!fasta_array_R1[@]}"
do
  echo "${fasta_array_R1[index]}" >> input.fasta.list.txt
  echo "${fasta_array_R2[index]}" >> input.fasta.list.txt
  python "${reago_filter}" \
  "${fasta_array_R1[index]}" \
  "${fasta_array_R2[index]}" \
  "${wd}" \
  "${cm_dir}" \
  "${cm_to_use}" \
  "${threads}"
done

# Run reago on filtered FastAs
for fasta in filtered.*.fasta
do
  python "${reago}" \
  "${fasta}" \
  "${fasta}".reago_out \
  -l 100
done
