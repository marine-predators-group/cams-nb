---
layout: post
title: Annotation - Olurida_v081 MAKER Proteins BLASTp on Mox
date: '2018-12-20 13:32'
tags:
  - Ostrea lurida
  - Olympia oyster
  - MAKER
  - blastp
  - Olurida_v081
categories:
  - Olympia Oyster Genome Sequencing
---
[After getting through the initial MAKER annotation and SNAP gene predictions](https://robertslab.github.io/sams-notebook/2018/11/27/Annotation-Olurida_v081-MAKER-on-Mox.html), I needed to run BLASTp on the FastA file produced by MAKER in order to assign some functionality to the predicted genes.

Input FastA (9.3MB):

- [20181127_oly_maker_genome_annotation/Olurida_v081.all.maker.proteins.fasta](http://gannet.fish.washington.edu/Atumefaciens/20181127_oly_maker_genome_annotation/Olurida_v081.all.maker.proteins.fasta)

SBATCH script (text file):

- [20181220_oly_maker_blastp/20181220_oly_maker_blastp.sh](http://gannet.fish.washington.edu/Atumefaciens/20181220_oly_maker_blastp/20181220_oly_maker_blastp.sh)

<pre><code>
#!/bin/bash
## Job Name
#SBATCH --job-name=blastp
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20181220_oly_maker_blastp

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Load Open MPI module for parallel, multi-node processing

module load icc_19-ompi_3.1.2

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log


# Add BLAST to system PATH
export PATH=$PATH:/gscratch/srlab/programs/ncbi-blast-2.6.0+/bin
export BLASTDB=/gscratch/srlab/blastdbs/UniProtKB_20181008/

# Define variables

blastp=/gscratch/srlab/programs/ncbi-blast-2.6.0+/bin/blastp
uniprot_db=/gscratch/srlab/blastdbs/UniProtKB_20181008/20181008_uniprot_sprot.fasta
maker_p_fasta=/gscratch/scrubbed/samwhite/outputs/20181127_oly_maker_genome_annotation/Olurida_v081.all.maker.proteins.fasta
output=/gscratch/scrubbed/samwhite/outputs/20181220_oly_maker_blastp/20181220_outfmt6.blastp

# Run blastp
${blastp} \
-query ${maker_p_fasta} \
-db ${uniprot_db} \
-out ${output} \
-max_target_seqs 1 \
-evalue 1e-6 \
-outfmt 6 \
-num_threads 28
</code></pre>

---

#### RESULTS

Output folder:

- [20181220_oly_maker_blastp/](http://gannet.fish.washington.edu/Atumefaciens/20181220_oly_maker_blastp/)

BLASTp output:

- [20181220_oly_maker_blastp/20181220_outfmt6.blastp](http://gannet.fish.washington.edu/Atumefaciens/20181220_oly_maker_blastp/20181220_outfmt6.blastp)

Great, now that I have this, I can use it to incorporate into the MAKER outputs (GFFs and FastA).
