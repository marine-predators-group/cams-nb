#!/bin/bash
## Job Name
#SBATCH --job-name=busco
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=2
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=15-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190114_oly_busco_augustus

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


## Establish variables for more readable code
wd=$(pwd)

bedtools=/gscratch/srlab/programs/bedtools-2.27.1/bin/bedtools
busco=/gscratch/srlab/programs/busco-v3/scripts/run_BUSCO.py
busco_db=/gscratch/srlab/sam/data/databases/BUSCO/eukaryota_odb9
busco_config_default=/gscratch/srlab/programs/busco-v3/config/config.ini.default
busco_config_ini=${wd}/config.ini
maker_dir=/gscratch/scrubbed/samwhite/outputs/20181127_oly_maker_genome_annotation
oly_genome=/gscratch/srlab/sam/data/O_lurida/oly_genome_assemblies/Olurida_v081/Olurida_v081.fa
oly_maker_gff=/gscratch/srlab/sam/data/O_lurida/oly_genome_assemblies/Olurida_v081/Olurida_v081.maker.all.noseqs.gff
blast_dir=/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/
augustus_bin=/gscratch/srlab/programs/Augustus-3.3.2/bin
augustus_scripts=/gscratch/srlab/programs/Augustus-3.3.2/scripts
augustus_config_dir=${wd}/augustus/config
augustus_orig_config_dir=/gscratch/srlab/programs/Augustus-3.3.2/config
hmm_dir=/gscratch/srlab/programs/hmmer-3.2.1/src/



# Export BUSCO config file location
export BUSCO_CONFIG_FILE="${busco_config_ini}"

# Export Augustus variable
export PATH="${augustus_bin}:$PATH"
export PATH="${augustus_scripts}:$PATH"
export AUGUSTUS_CONFIG_PATH="${augustus_config_dir}"



# Subset transcripts and include +/- 1000bp on each side.
## Reduces amount of data used for training - don't need crazy amounts to properly train gene models
awk -v OFS="\t" '{ if ($3 == "mRNA") print $1, $4, $5 }' ${oly_maker_gff} | \
awk -v OFS="\t" '{ if ($2 < 1000) print $1, "0", $3+1000; else print $1, $2-1000, $3+1000 }' | \
${bedtools} getfasta -fi ${oly_genome} \
-bed - \
-fo Olurida_v081.all.maker.transcripts1000.fasta

cp Olurida_v081.all.maker.transcripts1000.fasta ${maker_dir}
cp ${busco_config_default} ${busco_config_ini}

mkdir augustus
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
--in Olurida_v081.all.maker.transcripts1000.fasta \
--out Olurida_maker_busco \
--lineage_path ${busco_db} \
--mode genome \
--cpu 56 \
--long \
--species human \
--tarzip \
--augustus_parameters='--progress=true'
