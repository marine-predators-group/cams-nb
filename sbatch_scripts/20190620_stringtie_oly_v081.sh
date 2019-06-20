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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190620_stringtie_oly_v081

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
gffread="/gscratch/srlab/programs/gffread-0.11.4.Linux_x86_64/gffread"
hisat2_dir="/gscratch/srlab/programs/hisat2-2.1.0"
hisat2_build="${hisat2_dir}/hisat2-build"
hisat2_exons="${hisat2_dir}/hisat2_extract_exons.py"
hisat2_splice_sites="${hisat2_dir}/hisat2_extract_splice_sites.py"

# Input/output files
genome_gff="/gscratch/srlab/sam/data/O_lurida/genomes/Olurida_v081/20181127_oly_genome_snap02.all.renamed.putative_function.domain_added.gff"
genome_fasta="/gscratch/srlab/sam/data/O_lurida/genomes/Olurida_v081/Olurida_v081.fa"
exons="hisat2_exons.tab"
splice_sites="hisat2_splice_sites.tab"
transcripts_gtf="20181127_oly_genome_snap02.all.renamed.putative_function.domain_added.transcripts.gtf"

# Create transcipts GTF from genome FastA
"${gffread}" -T \
"${genome_gff}" \
-o "${transcripts_gtf}"

# Create Hisat2 exons tab file
"${hisat2_exons}" \
"${transcripts_gtf}" \
> "${exons}"
# Create Hisate2 splice sites tab file
"${hisat2_splice_sites}" \
"${transcripts_gtf}" \
> "${splice_sites}"

# Build Hisat2 reference index
"${hisat2_build}" \
"${genome_fasta}" \
--ss "${splice_sites}" \
--exon "${exons}" \
-p "${threads}"
