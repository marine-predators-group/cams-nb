---
layout: post
title: Transcriptome Annotation - Geoduck Heart with Trinotate on Mox
date: '2019-03-18 15:41'
tags:
  - geoduck
  - Panopea generosa
  - trinotate
  - mox
  - transcriptome
  - trinity
categories:
  - Miscellaneous
---
Trinity:

- [20190215 Heart Trinity](https://robertslab.github.io/sams-notebook/2019/02/15/Transcriptome-Assembly-Geoduck-Tissue-Specific-Assembly-Heart.html)

Transdecoder:

- [20190318 Heart Transdecoder](https://robertslab.github.io/sams-notebook/2019/03/18/Transcriptome-Annotation-Geoduck-Heart-with-Transdecoder-on-Mox.html)

BLASTx:

- [20190318 Heart BLASTx](https://robertslab.github.io/sams-notebook/2019/03/18/Transcriptome-Annotation-Geoduck-Heart-with-BLASTx-on-Mox.html)


SBATCH script (GitHub):

- [20190318_trinotate_geoduck_heart_RNAseq.sh](https://raw.githubusercontent.com/RobertsLab/sams-notebook/master/sbatch_scripts/20190318_trinotate_geoduck_heart_RNAseq.sh)

<pre><code>
#!/bin/bash
## Job Name
#SBATCH --job-name=tate_heart
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190318_trinotate_geoduck_heart_RNAseq

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
## Non-working directory locations
blastp_out_dir="/gscratch/scrubbed/samwhite/outputs/20190318_transdecoder_geoduck_heart_RNAseq/blastp_out"
blastx_out_dir="/gscratch/scrubbed/samwhite/outputs/20190318_blastx_geoduck_heart_RNAseq"
pfam_out_dir="/gscratch/scrubbed/samwhite/outputs/20190318_transdecoder_geoduck_heart_RNAseq/pfam_out"
trinity_out_dir="/gscratch/scrubbed/samwhite/outputs/20190215_trinity_geoduck_heart_RNAseq/trinity_out_dir"
transdecoder_out_dir="/gscratch/scrubbed/samwhite/outputs/20190318_transdecoder_geoduck_heart_RNAseq/Trinity.fasta.transdecoder_dir"



## New folders for working directory
rnammer_out_dir="${wd}/RNAmmer_out"
signalp_out_dir="${wd}/signalp_out"
tmhmm_out_dir="${wd}/tmhmm_out"


blastp_out="${blastp_out_dir}/blastp.outfmt6"
blastx_out="${blastx_out_dir}/blastx.outfmt6"
pfam_out="${pfam_out_dir}/pfam.domtblout"
lORFs_pep="${transdecoder_out_dir}/longest_orfs.pep"
rnammer_out="${rnammer_out_dir}/Trinity.fasta.rnammer.gff"
signalp_out="${signalp_out_dir}/signalp.out"
tmhmm_out="${tmhmm_out_dir}/tmhmm.out"
trinity_fasta="${trinity_out_dir}/Trinity.fasta"
trinity_gene_map="${trinity_out_dir}/Trinity.fasta.gene_trans_map"
trinotate_report="${wd}/trinotate_annotation_report.txt"



# Paths to programs
rnammer_dir="/gscratch/srlab/programs/RNAMMER-1.2"
rnammer="${rnammer_dir}/rnammer"
signalp_dir="/gscratch/srlab/programs/signalp-4.1"
signalp="${signalp_dir}/signalp"
tmhmm_dir="/gscratch/srlab/programs/tmhmm-2.0c/bin"
tmhmm="${tmhmm_dir}/tmhmm"
trinotate_dir="/gscratch/srlab/programs/Trinotate-v3.1.1"
trinotate="${trinotate_dir}/Trinotate"
trinotate_rnammer="${trinotate_dir}/util/rnammer_support/RnammerTranscriptome.pl"
pfam_db="${trinotate_dir}/admin/Pfam-A.hmm"
sp_db="${trinotate_dir}/admin/uniprot_sprot.pep"
trinotate_sqlite_db="Trinotate.sqlite"

# Make output directories
mkdir ${rnammer_out_dir} ${signalp_out_dir} ${tmhmm_out_dir}

# Copy sqlite database template

cp ${trinotate_dir}/admin/Trinotate.sqlite .

# Run signalp
${signalp} \
-f short \
-n ${signalp_out} \
${lORFs_pep}

# Run tmHMM
${tmhmm} \
--short \
< ${lORFs_pep} \
> ${tmhmm_out}

# Run RNAmmer
cd ${rnammer_out_dir}
${trinotate_rnammer} \
--transcriptome ${trinity_fasta} \
--path_to_rnammer ${rnammer}
cd ${wd}

# Run Trinotate
## Load transcripts and coding regions into database
${trinotate} \
${trinotate_sqlite_db} \
init \
--gene_trans_map ${trinity_gene_map} \
--transcript_fasta ${trinity_fasta} \
--transdecoder_pep ${lORFs_pep}

## Load BLAST homologies
${trinotate} \
${trinotate_sqlite_db} \
LOAD_swissprot_blastp \
${blastp_out}

${trinotate} \
${trinotate_sqlite_db} \
LOAD_swissprot_blastx \
${blastx_out}

## Load Pfam
${trinotate} \
${trinotate_sqlite_db} \
LOAD_pfam \
${pfam_out}

## Load transmembrane domains
${trinotate} \
${trinotate_sqlite_db} \
LOAD_tmhmm \
${tmhmm_out}

## Load signal peptides
${trinotate} \
${trinotate_sqlite_db} \
LOAD_signalp \
${signalp_out}

## Load RNAmmer
${trinotate} \
${trinotate_sqlite_db} \
LOAD_rnammer \
${rnammer_out}

## Creat annotation report
${trinotate} \
${trinotate_sqlite_db} \
report \
> ${trinotate_report}
</code></pre>

---

#### RESULTS

Output folder:

- [20190318_trinotate_geoduck_heart_RNAseq/](http://gannet.fish.washington.edu/Atumefaciens/20190318_trinotate_geoduck_heart_RNAseq/)

Trinotate Annotation Table (text):

- [20190318_trinotate_geoduck_heart_RNAseq/trinotate_annotation_report.txt](http://gannet.fish.washington.edu/Atumefaciens/20190318_trinotate_geoduck_heart_RNAseq/trinotate_annotation_report.txt)

Trinotate SQLlite Database:

- [20190318_trinotate_geoduck_heart_RNAseq/Trinotate.sqlite](http://gannet.fish.washington.edu/Atumefaciens/20190318_trinotate_geoduck_heart_RNAseq/Trinotate.sqlite)
