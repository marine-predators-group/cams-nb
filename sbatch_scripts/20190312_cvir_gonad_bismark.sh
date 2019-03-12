#!/bin/bash
## Job Name
#SBATCH --job-name=bismark
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=10-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/2019312_cvir_gonad_bismark

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log


# Directories and programs
wd=$(pwd)
bismark_dir="/gscratch/srlab/programs/Bismark-0.19.0"
bowtie2_dir="/gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64/"
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
reads_dir="/gscratch/srlab/sam/data/C_virginica/bsseq"

## genomes

genome="/gscratch/srlab/sam/data/C_virginica/genomes/"

## Concatenated FastQ Files
R1="${wd}/cvir_bsseq_all_pe_R1.fastq.gz"
R2="${wd}/cvir_bsseq_all_pe_R2.fastq.gz"

## FastQ files lists
R1_list="${wd}/cvir_bsseq_pe_all_R1.list"
R2_list="${wd}/cvir_bsseq_pe_all_R2.list"

# Initialize variables
total_reads=0
avg_reads=0
half_avg_reads=0
half_total_reads=0
reads_set_array=()
R1_array=()
R2_array=()


## Save FastQ files to arrays
R1_array=(${reads_dir}/*_R1_*.fq.gz)
R2_array=(${reads_dir}/*_R2_*.fq.gz)

# Number of libraries by counting elements in array
num_libs=$(echo ${#R1_array[@]})

# Add names to array
reads_set_names_array=("avg_reads" "half_avg_reads" "half_total_reads" "total_reads")

# Check for existence of previous concatenation
# If they exist, delete them

for file in ${R1} ${R1_list} ${R2} ${R2_list}
do
  if [ -e ${file} ]; then
    rm ${file}
  fi
done



# Determine total reads counts from all libraries
## Iterates through arrays and determines read counts
## by counting lines in FastQ and dividing by 4.
## Each loop adds the read1 and read2 read counts to the total
for fastq in "${!R1_array[@]}"
do
  R1_fastq=${R1_array[fastq]}
  R2_fastq=${R2_array[fastq]}
  lib_name=$(echo ${fastq} | awk -F'_' '{ print $3 }')
  R1_count=$(echo $(zcat ${R1_fastq} | wc -l)/4 | bc)
  R2_count=$(echo $(zcat ${R2_fastq} | wc -l)/4 | bc)
  total_reads=$(echo ${R1_count} + ${R2_count} + ${total_reads}| bc)
done

# Calcuations for different read amounts desired for analysis.
avg_reads=$(echo ${total_reads}/${num_libs} | bc)
half_avg_reads=$(echo "${avg_reads} * 0.5" | bc)
half_total_reads=$(echo "${total_reads} * 0.5" | bc)

# Store calculated values in array
reads_set_array=(${avg_reads} ${half_avg_reads} ${half_total_reads} ${total_reads})

# Concatenate R1 reads and generate lists of FastQs
for fastq in ${reads_dir}*R1*.gz
do
  echo ${fastq} >> ${R1_list}
  cat ${fastq} >> ${R1}
done

# Concatenate R2 reads and generate lists of FastQs
for fastq in ${reads_dir}*R2*.gz
do
  echo ${fastq} >> ${R2_list}
  cat ${fastq} >> ${R2}
done

# Run bismark using bisulftie-converted genome
for set in "${!reads_set_names_array[@]}"
do
  set_name=${reads_set_names_array[set]}
  reads_set=${reads_set_array[set]}
  mkdir ${set_name}_bismark
  cd ${set_name}_bismark
  ${bismark_dir}/bismark \
  --path_to_bowtie ${bowtie2_dir} \
  --genome ${genome} \
  --score_min L,0,-0.6 \
  -u ${reads_set} \
  -p 28 \
  -1 ${R1} \
  -2 ${R2} \
  2> ${set_name}_summary.txt

  # Deduplicate bam files
  ${bismark_dir}/deduplicate_bismark \
  --bam \
  --single \
  *.bam

  # Methylation extraction

  ${bismark_dir}/bismark_methylation_extractor \
  --bedgraph \
  --counts \
  --scaffolds \
  --remove_spaces \
  --multicore 28 \
  --buffer_size 75% \
  *deduplicated.bam

  # Bismark processing report

  ${bismark_dir}/bismark2report

  #Bismark summary report

  ${bismark_dir}/bismark2summary

  # Sort files for methylkit and IGV

  find *deduplicated.bam \
  | xargs basename -s .bam \
  | xargs -I{} ${samtools} \
  sort \
  --threads 28 \
  {}.bam \
  -o {}.sorted.bam

  # Index sorted files for IGV
  # The "-@ 28" below specifies number of CPU threads to use.

  find *.sorted.bam \
  | xargs basename -s .sorted.bam \
  | xargs -I{} ${samtools} \
  index -@ 28 \
  {}.sorted.bam
  cd ${wd}
done
