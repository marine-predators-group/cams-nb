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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190401_metagenomics_pgen_anvio

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
cpus=28
megahit_out_dir=/gscratch/scrubbed/samwhite/outputs/20190327_metagenomics_pgen_megahit
fastq_dir=/gscratch/srlab/sam/data/metagenomics/P_generosa

## Inititalize arrays
samples_array=(MG1 MG2 MG3 MG5 MG6 MG7)
fastq_array_R1=()
fastq_array_R2=()
fasta_array=()

## Programs
bbmap_dir=/gscratch/srlab/programs/bbmap_38.34
anvi_dir=/gscratch/srlab/programs/anaconda3/bin
samtools=/gscratch/srlab/programs/samtools-1.9/samtools

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

# Create list of fastq files used in analysis
## Uses parameter substitution to strip leading path from filename
for fastq in ${fastq_dir}*.gz
do
  echo ${fastq#${fastq_dir}} >> fastq.list.txt
done

# Create FastA array
for sample in ${!samples_array[@]}
do
  sample_name=$(echo ${samples_array[sample]})
  fasta_array+=(${megahit_out_dir}/${sample_name}/megahit_out/${sample_name}.contigs.fa)
done

# Re-label FastAs
for sample in ${!samples_array[@]}
do
  sample_name=$(echo ${samples_array[sample]})
  # Reformat FastA deflines
  ${anvi_dir}/anvi-script-reformat-fasta \
  ${fasta_array[sample]} \
  -o ${sample_name}.renamed.fa \
  --simplify-names \
  -l 0 \
  --report-file
  # Create FastA index
  ${samtools} faidx ${sample_name}.renamed.fa
  # Map reads to FastAs
  ${bbmap_dir}/bbwrap.sh \
  ref=${sample_name}.renamed.fa \
  in1=${fastq_array_R1[sample]} \
  in2=${fastq_array_R2[sample]} \
  out=${sample_name}.aln.sam.gz
  # Convert SAM to BAM
  gunzip < ${sample_name}.aln.sam.gz > ${sample_name}.RAW.sam
  ${samtools} view -bS --threads ${cpus} ${sample_name}.RAW.sam
  ${anvi_dir}/anvi-init-bam \
  ${sample_name}.RAW.bam \
  -o ${sample_name}.bam
  # Create Anvio database
  ${anvi_dir}/anvi-gen-contigs-database \
  -f ${sample_name}.renamed.fa \
  -o ${sample_name}.db
  # Run HMMs
  ${anvi_dir}/anvi-run-hmms \
  -c ${sample_name}.db \
  --num-threads ${cpus}
  # Assign Clusters of Orthologous Groups (COGs)
  ${anvi_dir}/anvi-run-ncbi-cogs \
  -c ${sample_name}.db \
  --num-threads ${cpus}
