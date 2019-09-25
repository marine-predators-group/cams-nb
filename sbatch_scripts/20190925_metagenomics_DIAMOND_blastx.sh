#!/bin/bash
## Job Name
#SBATCH --job-name=metagenomics_DIAMOND
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
#SBATCH --chdir=/gscratch/scrubbed/samwhite/outputs/20190925_metagenomics_DIAMOND_blastx

# Exit script if any command fails
set -e

# Load Python Mox module for Python module availability

module load intel-python3_2017

# SegFault fix?
export THREADS_DAEMON_MODEL=1

# Document programs in PATH (primarily for program version ID)

{
date
echo ""
echo "System PATH for $SLURM_JOB_ID"
echo ""
printf "%0.s-" {1..10}
echo "${PATH}" | tr : \\n
} >> system_path.log


# Program paths
diamond=/gscratch/srlab/programs/diamond-0.9.26/diamond
meganizer=/gscratch/srlab/programs/MEGAN6/tools/daa-meganizer

# DIAMOND NCBI nr database
dmnd=/gscratch/srlab/blastdbs/ncbi-nr-20190925/nr.dmnd

# MEGAN mapping files
prot_acc2tax=/gscratch/srlab/sam/data/databases/MEGAN/prot_acc2tax-Jul2019X1.abin
acc2interpro=/gscratch/srlab/sam/data/databases/MEGAN/acc2interpro-Jul2019X.abin
acc2eggnog=/gscratch/srlab/sam/data/databases/MEGAN/acc2eggnog-Jul2019X.abin

# FastQ files directory
fastq_dir=/gscratch/srlab/sam/data/metagenomics/P_generosa/


# Loop through FastQ files, log filenames to fastq_list.txt.
# Run DIAMOND on each FastQ
# Run MEGANIZER on each DIAMOND output file
for fastq in ${fastq_dir}*.fq.gz
do
	# Log input FastQs
	echo "${fastq}" >> fastq_list.txt

	# Strip leading path and extensions
	no_path=$(echo "${fastq##*/}")
	no_ext=$(echo "${no_path%%.*}")

	# Run DIAMOND with blastx
	${diamond} blastx \
	--db ${dmnd} \
	--query "${fastq}" \
	--out "${no_ext}".blastx.daa \
	--outfmt 100 \
	--top 5 \
	--block-size 20.0 \
	--index-chunks 2

	# MEGANIZE .daa files
	${meganizer} \
	--acc2taxa ${prot_acc2tax} \
	--acc2interpro2go ${acc2interpro} \
	--acc2eggnog ${acc2eggnog} \
	"${no_ext}".blastx.daa
done
