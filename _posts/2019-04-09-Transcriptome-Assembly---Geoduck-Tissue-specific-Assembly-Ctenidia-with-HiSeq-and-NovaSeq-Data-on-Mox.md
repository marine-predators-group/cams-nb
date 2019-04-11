---
layout: post
title: Transcriptome Assembly - Geoduck Tissue-specific Assembly Ctenidia with HiSeq and NovaSeq Data on Mox
date: '2019-04-09 06:44'
tags:
  - Panopea generosa
  - geoduck
  - trinity
  - mox
  - assembly
  - transcriptome
categories:
  - Miscellaneous
---

I previously assembled and annotated _P.generosa_ ctenidia transcriptome ([20190318](https://robertslab.github.io/sams-notebook/2019/03/18/Transcriptome-Annotation-Geoduck-Ctenidia-with-Trinotate-on-Mox.html)) using just our HiSeq data from our Illumina collaboration. This was a an oversight, as I didn't realize that we also had NovaSeq RNAseq data. So, I've initiated another _de novo_ assembly using Trinity incorporating both sets of data.

NovaSeq data had been [previously trimmed](https://robertslab.github.io/sams-notebook/2018/01/25/adapter-trimming-and-fastqc-illumina-geoduck-novaseq-data.html).

Trimming of the HiSeq data was performed via Trinity, using the `--trimmomatic` option.

SBATCH script (GitHub):

- [20190409_trinity_pgen_ctenidia_RNAseq.sh](https://github.com/RobertsLab/sams-notebook/blob/master/sbatch_scripts/20190409_trinity_pgen_ctenidia_RNAseq.sh)

<pre><code>
#!/bin/bash
## Job Name
#SBATCH --job-name=trin_ctenidia
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=30-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190409_trinity_pgen_ctenidia_RNAseq

# Exit script if a command fails
set -e

# Load Python Mox module for Python module availability
module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)
date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log

# User-defined variables
reads_dir=/gscratch/scrubbed/samwhite/data/P_generosa/RNAseq/ctenidia
threads=28
assembly_stats=assembly_stats.txt

# Paths to programs
trinity_dir="/gscratch/srlab/programs/Trinity-v2.8.3"
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"


## Inititalize arrays
R1_array=()
R2_array=()

# Variables for R1/R2 lists
R1_list=""
R2_list=""

# Create array of fastq R1 files
R1_array=(${reads_dir}/*_R1_*.gz)

# Create array of fastq R2 files
R2_array=(${reads_dir}/*_R2_*.gz)

# Create list of fastq files used in analysis
## Uses parameter substitution to strip leading path from filename
for fastq in ${reads_dir}/*.gz
do
  echo ${fastq##*/} >> fastq.list.txt
done

# Create comma-separated lists of FastQ reads
R1_list=$(echo ${R1_array[@]} | tr " " ",")
R2_list=$(echo ${R2_array[@]} | tr " " ",")


# Run Trinity
${trinity_dir}/Trinity \
--trimmomatic \
--seqType fq \
--max_memory 120G \
--CPU ${threads} \
--left \
${R1_list} \
--right \
${R2_list}

# Assembly stats
${trinity_dir}/util/TrinityStats.pl trinity_out_dir/Trinity.fasta \
> ${assembly_stats}

# Create gene map files
${trinity_dir}/util/support_scripts/get_Trinity_gene_to_trans_map.pl \
trinity_out_dir/Trinity.fasta \
> trinity_out_dir/Trinity.fasta.gene_trans_map

# Create FastA index
${samtools} faidx \
trinity_out_dir/Trinity.fasta
</code></pre>

---

#### RESULTS

This took ~12hrs to complete.

I'll pass this along to Steven/Christian, since this was done for Christian to use in some long, non-coding RNA (lncRNA) analysies.

I'll also probably just take this through the annotation pipeline, since it's not difficult, nor time consuming.

Output folder:

- [20190409_trinity_pgen_EPI115_RNAseq](http://gannet.fish.washington.edu/Atumefaciens/20190409_trinity_pgen_EPI115_RNAseq/)

Trinity FastA:

- 20190409_trinity_pgen_EPI115_RNAseq/trinity_out_dir/Trinity.fasta[](http://gannet.fish.washington.edu/Atumefaciens/20190409_trinity_pgen_EPI115_RNAseq/trinity_out_dir/Trinity.fasta)

Trinity FastA index file:

- [20190409_trinity_pgen_EPI115_RNAseq/trinity_out_dir/Trinity.fasta.fai](http://gannet.fish.washington.edu/Atumefaciens/20190409_trinity_pgen_EPI115_RNAseq/trinity_out_dir/Trinity.fasta.fai)

Trinity Gene Trans Map file:

- [20190409_trinity_pgen_EPI115_RNAseq/trinity_out_dir/Trinity.fasta.gene_trans_map](http://gannet.fish.washington.edu/Atumefaciens/20190409_trinity_pgen_EPI115_RNAseq/trinity_out_dir/Trinity.fasta.gene_trans_map)


Assembly stats (text):

- [20190409_trinity_pgen_EPI115_RNAseq/assembly_stats.txt](http://gannet.fish.washington.edu/Atumefaciens/20190409_trinity_pgen_EPI115_RNAseq/assembly_stats.txt)

```
################################
## Counts of transcripts, etc.
################################
Total trinity 'genes':	199765
Total trinity transcripts:	320691
Percent GC: 36.50

########################################
Stats based on ALL transcript contigs:
########################################

	Contig N10: 5803
	Contig N20: 3937
	Contig N30: 2902
	Contig N40: 2153
	Contig N50: 1581

	Median contig length: 411
	Average contig: 842.06
	Total assembled bases: 270039845


#####################################################
## Stats based on ONLY LONGEST ISOFORM per 'GENE':
#####################################################

	Contig N10: 4344
	Contig N20: 2835
	Contig N30: 1998
	Contig N40: 1433
	Contig N50: 1002

	Median contig length: 339
	Average contig: 641.10
	Total assembled bases: 128069660
  ```
