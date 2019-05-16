#!/bin/bash
## Job Name
#SBATCH --job-name=blastx_metagenomics
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190516_metagenomics_pgen_blastx

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


threads=28

# Paths to programs
blast_dir="/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin"
blastx="${blast_dir}/blastx"


# Paths to blastdbs
blastdb_dir="/gscratch/srlab/blastdbs/ncbi-sp-v5"
blast_db="${blastdb_dir}/swissprot_v5"


# Input files
fasta_dir="/gscratch/srlab/sam/data/metagenomics/P_generosa/assemblies/"


## Inititalize arrays
fasta_array=()
names_array=()

# Export BLAST database directory
export BLASTDB=${blastdb_dir}

# Create array of FastA files
# Create array of sample names
## Uses parameter substitution to strip leading path from filename
for fasta in ${fasta_dir}/MG*.fa
do
  fasta_array+=(${fastq})
  names_array+=($(echo "${fasta#${fasta_dir}}" | awk -F"." '{print $1}'))
done



# Loop through arrays to customize sample names
# and run BLASTx on each FastA
for index in "${!names_array[@]}"
do
  # Loops through sample names and appends appropriate treatment to each sample name
  sample_name=$(echo "${names_array[index]}")
  if [ "${sample_name}" == "MG1" ] \
  || [ "${sample_name}" == "MG2" ] \
  || [ "${sample_name}" == "MG5" ]
  then
    sample_name="${sample_name}"_pH82
  else
    sample_name="${sample_name}"_pH71
  fi

  # Create list of input FastA files
  echo "${fasta}" >> input.fasta.list.txt

  # Run BLASTx on each FastA
  ${blastx} \
  -query "${fasta_array[index]}" \
  -db ${blast_db} \
  -max_hsps 1 \
  -outfmt "6 std staxid ssciname" \
  -evalue 1e-10 \
  -num_threads ${threads} \
  > "${sample_name}".blastx.outfmt6
done
