#!/usr/bin/bash

# Script to retrieve geoduck Trinity assemblies
# Assemblies will be used in SBATCH script called at end of this script.

# Create array of directories for storing Trinity assemblies
assembly_dirs_array=(
/gscratch/srlab/sam/data/P_generosa/transcriptomes/20190827_assembly \
/gscratch/srlab/sam/data/P_generosa/transcriptomes/ctenidia \
/gscratch/srlab/sam/data/P_generosa/transcriptomes/gonad \
/gscratch/srlab/sam/data/P_generosa/transcriptomes/heart \
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI115 \
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI116 \
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI123 \
/gscratch/srlab/sam/data/P_generosa/transcriptomes/juvenile/EPI124 \
/gscratch/srlab/sam/data/P_generosa/transcriptomes/larvae/EPI99)

# Array of Trinity assemblies for rysnc-ing
assemblies_array
