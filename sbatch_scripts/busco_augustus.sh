#!/bin/bash
## Job Name
#SBATCH --job-name=busco
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=15-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190115_oly_busco_metazoa_augustus

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


# Establish variables for more readable code

## Input files and settings
base_name=Olurida_v081.all.maker
busco_db=/gscratch/srlab/sam/data/databases/BUSCO/metazoa_odb9
genome_fasta=/gscratch/srlab/sam/data/O_lurida/oly_genome_assemblies/Olurida_v081/Olurida_v081.all.maker.transcripts.fasta
genome_index=/gscratch/srlab/sam/data/O_lurida/oly_genome_assemblies/Olurida_v081/Olurida_v081.all.maker.transcripts.fasta.fai
maker_gff=/gscratch/srlab/sam/data/O_lurida/oly_genome_assemblies/Olurida_v081/Olurida_v081.maker.all.noseqs.gff
augustus_species=${human}


## Output files
longest_transcripts_fasta=${base_name}.longest.transcripts.fa
longest_trascripts_fai=${longest_transcripts_fasta}.fai
longest_transctipts_list=${base_name}.longest.list
augustus_retrain_params=run_${base_name}_busco/augustus_output/retraining_parameters

## Save working directory
wd=$(pwd)

## Set program paths
augustus_bin=/gscratch/srlab/programs/Augustus-3.3.2/bin
augustus_scripts=/gscratch/srlab/programs/Augustus-3.3.2/scripts
bedtools=/gscratch/srlab/programs/bedtools-2.27.1/bin/bedtools
blast_dir=/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/
busco=/gscratch/srlab/programs/busco-v3/scripts/run_BUSCO.py
hmm_dir=/gscratch/srlab/programs/hmmer-3.2.1/src/
samtools=/gscratch/srlab/programs/samtools-1.9/samtools

## Augustus configs
augustus_dir=${wd}/augustus
augustus_config_dir=${augustus_dir}/config
augustus_orig_config_dir=/gscratch/srlab/programs/Augustus-3.3.2/config

## BUSCO configs
busco_config_default=/gscratch/srlab/programs/busco-v3/config/config.ini.default
busco_config_ini=${wd}/config.ini

# Export BUSCO config file location
export BUSCO_CONFIG_FILE="${busco_config_ini}"

# Export Augustus variable
export PATH="${augustus_bin}:$PATH"
export PATH="${augustus_scripts}:$PATH"
export AUGUSTUS_CONFIG_PATH="${augustus_config_dir}"

# Creates a list of a subset transcripts to use longest transcript for each isoform.
## Reduces amount of data used for training - don't need crazy amounts to properly train gene models.
## Eliminates duplicate transcripts which improves BUSCO analysis.
### Command sets two field separators (tab for genome index file and '-' for FastA).
### Sorts in numerical reverse order on field #8 - sequence length.
### Then sorts unique names on field #2 - gene ID.
### Then cuts fields #1-7 and translates the spaces back to hyphens to restore original formatting.
awk -F'[\t-]' '{print $1,$2,$3,$4,$5,$6,$7,$8}' ${genome_index} \
| sort -k8nr,8 \
| sort -uk2,2 \
| cut -f1-7 -d' ' \
| tr ' ' '-' \
> ${longest_transctipts_list}

## Create FastA from list of longeset transcripts
while read contig; do ${samtools} faidx ${genome_index} $contig >> ${longest_transcripts_fasta}; done < ${longest_transctipts_list}

## Index longest transcripts FastA, for posterity.
${samtools} faidx ${longest_transcripts_fasta}

# Copy BUSCO config file
cp ${busco_config_default} ${busco_config_ini}

# Make Augustus directory if it doesn't exist
if [ ! -d mkdir ${augustus_dir} ]; then
  mkdir ${augustus_dir}
fi

# Copy Augustus config directory
cp -pr ${augustus_orig_config_dir} ${augustus_config_dir}

# Edit BUSCO config file
## Set paths to various programs
### The use of the % symbol sets the delimiter sed uses for arguments.
### Normally, the delimiter that most examples use is a slash "/".
### But, we need to expand the variables into a full path with slashes, which screws up sed.
### Thus, the use of % symbol instead (it could be any character that is NOT present in the expanded variable; doesn't have to be "%").

sed -i "/^tblastn_path/ s%tblastn_path = /usr/bin/%path = ${blast_dir}%" "${busco_config_ini}"
sed -i "/^makeblastdb_path/ s%makeblastdb_path = /usr/bin/%path = ${blast_dir}%" "${busco_config_ini}"
sed -i "/^augustus_path/ s%augustus_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/bin/%path = ${augustus_bin}%" "${busco_config_ini}"
sed -i "/^etraining_path/ s%etraining_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/bin/%path = ${augustus_bin}%" "${busco_config_ini}"
sed -i "/^gff2gbSmallDNA_path/ s%gff2gbSmallDNA_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/scripts/%path = ${augustus_scripts}%" "${busco_config_ini}"
sed -i "/^new_species_path/ s%new_species_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/scripts/%path = ${augustus_scripts}%" "${busco_config_ini}"
sed -i "/^optimize_augustus_path/ s%optimize_augustus_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/scripts/%path = ${augustus_scripts}%" "${busco_config_ini}"
sed -i "/^hmmsearch_path/ s%hmmsearch_path = /home/osboxes/BUSCOVM/hmmer/hmmer-3.1b2-linux-intel-ia32/binaries/%path = ${hmm_dir}%" "${busco_config_ini}"


# Run BUSCO/Augustus training
${busco} \
--in ${longest_transcripts_fasta} \
--out ${base_name} \
--lineage_path ${busco_db} \
--mode genome \
--cpu 56 \
--long \
--species ${augustus_species} \
--tarzip \
--augustus_parameters='--progress=true'

# Prep Augusts for maker_dir

/gscratch/scrubbed/samwhite/outputs/20190114_oly_busco_augustus/run_Olurida_maker_busco/augustus_output/retraining_parameters
