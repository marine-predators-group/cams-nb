#!/usr/bin/bash


# Script to retrieve geoduck Trinity assemblies
# Assemblies will be used in SBATCH script called at end of this script.

gannet="gannet:/volume2/web/Atumefaciens"

# Create array of directories for storing Trinity assemblies
assembly_dirs_array=(
/gscratch/srlab/sam/data/P_generosa/transcriptomes/20190827_assembly
/gscratch/srlab/sam/data/P_generosa/transcriptomes/ctenidia
/gscratch/srlab/sam/data/P_generosa/transcriptomes/gonad
/gscratch/srlab/sam/data/P_generosa/transcriptomes/heart
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI115
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI116
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI123
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI124
/gscratch/srlab/sam/data/P_generosa/transcriptomes/larvae/EPI99)

# Array of Trinity assemblies remote paths for rysnc-ing
assemblies_array=(
20180827_trinity_geoduck_RNAseq/Trinity.fasta
20190409_trinity_pgen_ctenidia_RNAseq/trinity_out_dir/Trinity.fasta
20190409_trinity_pgen_gonad_RNAseq/trinity_out_dir/Trinity.fasta
20190215_trinity_geoduck_heart_RNAseq/trinity_out_dir/Trinity.fasta
20190409_trinity_pgen_EPI115_RNAseq/trinity_out_dir/Trinity.fasta
20190409_trinity_pgen_EPI116_RNAseq/trinity_out_dir/Trinity.fasta
20190409_trinity_pgen_EPI123_RNAseq/trinity_out_dir/Trinity.fasta
20190409_trinity_pgen_EPI124_RNAseq/trinity_out_dir/Trinity.fasta
20190409_trinity_pgen_EPI99_RNAseq/trinity_out_dir/Trinity.fasta)


for index in "${!assemblies_array[@]}"
do
  rsync \
  --archive \
  "${gannet}""${assemblies_array[index]} \
  "${assembly_dirs_array[index]}"
done
