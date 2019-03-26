---
layout: post
title: Metagenomics - Taxonomic Diversity from Geoduck Water with BLASTn and Krona Plots
date: '2019-03-25 20:26'
tags:
  - geoduck
  - Panopea generosa
  - blastn
  - krona
  - metagenomics
categories:
  - Miscellaneous
---

SBATCH script:

- [20190325_blastn_metagenomics_geoduck_metagenemark.sh](https://github.com/RobertsLab/sams-notebook/blob/master/sbatch_scripts/20190325_blastn_metagenomics_geoduck_metagenemark.sh)

<pre><code>
#!/bin/bash
## Job Name
#SBATCH --job-name=blastn_metagenomics
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190325_blastn_metagenomics_geoduck_metagenemark

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log


wd="$(pwd)"


# Paths to input/output files
blastn_out="${wd}/blastn.outfmt6"
blastdb_dir="/gscratch/srlab/blastdbs/ncbi-nr-nt-v5"
blast_db="${blastdb_dir}/nt"
fasta="/gscratch/srlab/sam/data/metagenomics/P_generosa/assemblies/20190103-mgm-nucleotides.fa"

# Paths to programs
blast_dir="/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin"
blastn="${blast_dir}/blastn"

export BLASTDB=${blastdb_dir}

# Run blastx on Trinity fasta
${blastn} \
-query ${fasta} \
-db ${blast_db} \
-max_target_seqs 1 \
-outfmt "6 std staxids" \
-evalue 1e-10 \
-num_threads 28 \
> ${blastn_out}

</code></pre>





---

#### RESULTS

Output folder:

- []()

BLASTn output (tab-delimited text):

- []()

Krona plot (HTML):

- []()
