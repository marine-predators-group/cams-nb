#!/bin/bash
## Job Name
#SBATCH --job-name=trinity_20190215
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=2
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=5-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190409_trinity_pgen_EPI124_RNAseq.sh

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log

data_dir=/gscratch/scrubbed/samwhite/data/P_generosa/RNAseq
trinity_dir=/gscratch/srlab/programs/Trinity-v2.8.3
assembly_stats=assembly_stats.txt

## Inititalize arrays
fastq_array_R1=()
fastq_array_R2=()

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
for fastq in ${fastq_dir}/*.gz
do
  echo ${fastq##*/} >> fastq.list.txt
done

# Run Trinity
${trinity_dir}/Trinity \
--trimmomatic \
--seqType fq \
--max_memory 120G \
--CPU 56 \
--left \

--right \


# Assembly stats
${trinity_dir}/util/TrinityStats.pl trinity_out_dir/Trinity.fasta \
> ${assembly_stats}

# Create gene map files
${trinity_dir}/util/support_scripts/get_Trinity_gene_to_trans_map.pl \
trinity_out/Trinity.fasta \
> trinity_out/Trinity.fasta.gene_trans_map
