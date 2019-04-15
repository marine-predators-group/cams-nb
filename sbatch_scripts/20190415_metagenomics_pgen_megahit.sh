#!/bin/bash
## Job Name
#SBATCH --job-name=megahit
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190415_metagenomics_pgen_megahit

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
echo ${PATH} | tr : \\n >> system_path.log


# variables
wd=$(pwd)
fastq_dir=/gscratch/srlab/sam/data/metagenomics/P_generosa
megahit=/gscratch/srlab/programs/megahit_v1.1.4_LINUX_CPUONLY_x86_64-bin/megahit
bbmap_dir=/gscratch/srlab/programs/bbmap_38.34
samtools=/gscratch/srlab/programs/samtools-1.9/samtools
cpus=28

## Inititalize arrays
fastq_array_R1=()
fastq_array_R2=()
names_array=(pH71 pH82)

# Create list of input FastQs used for concatenation
# Concatenate all pH7.1 R1 FastQs
for fastq in Library_Geoduck_MG_[367]*_R1_*.gz
do
  echo ${fastq} >> fastq.list.pH71.txt
  cat ${fastq} >> pH71.all.R1.fq.gz
done

# Create list of input FastQs used for concatenation
# Concatenate all pH7.1 R2 FastQs
for fastq in Library_Geoduck_MG_[367]*_R2_*.gz
do
  echo ${fastq} >> fastq.list.pH71.txt
  cat ${fastq} >> pH71.all.R2.fq.gz
done


# Create list of input FastQs used for concatenation
# Concatenate all pH8.2 R1 FastQs
for fastq in Library_Geoduck_MG_[125]*_R1_*.gz
do
  echo ${fastq} >> fastq.list.pH82.txt
  cat ${fastq} >> pH82.all.R1.fq.gz
done


# Create list of input FastQs used for concatenation
# Concatenate all pH8.2 R2 FastQs
for fastq in Library_Geoduck_MG_[125]*_R2_*.gz
do
  echo ${fastq} >> fastq.list.pH82.txt
  cat ${fastq} >> pH82.all.R2.fq.gz
done

# Populate R1 array with concatenated R1 FastQs
for fastq in *R1*.fq.gz
do
  fastq_array_R1+=(${fastq})
done

# Populate R2 array with concatenated R2 FastQs
for fastq in *R2*.gz
do
  fastq_array_R2+=(${fastq})
done

# Loop through samples
for sample in ${!names_array[@]}
do
  sample_name=$(echo ${names_array[sample]})
  mkdir ${sample_name} && cd ${sample_name}
  # Run Megahit using paired-end reads
  ${megahit} \
  -1 ${fastq_array_R1[sample]} \
  -2 ${fastq_array_R2[sample]} \
  --num-cpu-threads ${cpus} \
  --out-prefix ${sample_name}

  # Create FastA index file
  ${samtools} faidx megahit_out/${sample_name}.contigs.fa

  # Determine coverage
  ## Align reads with BBmap BBwrap
  ${bbmap_dir}/bbwrap.sh \
  ref=megahit_out/${sample_name}.contigs.fa \
  in1=${fastq_array_R1[sample]} \
  in2=${fastq_array_R2[sample]} \
  out=${sample_name}.aln.sam.gz

  ## Output contig coverage
  ${bbmap_dir}/pileup.sh \
  in=${sample_name}.aln.sam.gz \
  out=${sample_name}.coverage.txt

  # Return to working directory
  cd ${wd}
done
