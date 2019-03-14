/---
layout: post
title: Transcriptome Assembly - Geoduck Tissue-specific Assembly (Gonad)
date: '2019-02-15 22:42'
tags:
  - gonad
  - Trinity
  - geoduck
  - Panopea generosa
  - transcriptome
  - mox
  - gonad
categories:
  - Miscellaneous
---



SBATCH script:

- [20190215_geo_trinity_gonad_01.sh](https://raw.githubusercontent.com/RobertsLab/sams-notebook/master/sbatch_scripts/20190215_geo_trinity_gonad_01.sh)

<pre><code>
#!/bin/bash
## Job Name
#SBATCH --job-name=trinity_20190215
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=2
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=5-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190215_trinity_geoduck_gonad_01_RNAseq

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log

data_dir=/gscratch/scrubbed/samwhite/data/P_generosa/RNAseq
trinity_dir=/gscratch/srlab/programs/Trinity-v2.8.3
assembly_stats=assembly_stats.txt

# Run Trinity
${trinity_dir}/Trinity \
--trimmomatic \
--seqType fq \
--max_memory 120G \
--CPU 56 \
--left \
${data_dir}/Geoduck-gonad-RNA-1_S1_L001_R1_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-2_S9_L002_R1_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-3_S17_L003_R1_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-4_S25_L004_R1_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-5_S33_L005_R1_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-6_S41_L006_R1_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-7_S49_L007_R1_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-8_S57_L008_R1_001.fastq.gz \
--right \
${data_dir}/Geoduck-gonad-RNA-1_S1_L001_R2_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-2_S9_L002_R2_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-3_S17_L003_R2_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-4_S25_L004_R2_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-5_S33_L005_R2_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-6_S41_L006_R2_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-7_S49_L007_R2_001.fastq.gz,\
${data_dir}/Geoduck-gonad-RNA-8_S57_L008_R2_001.fastq.gz

# Assembly stats
${trinity_dir}/util/TrinityStats.pl trinity_out_dir/Trinity.fasta \
> ${assembly_stats}
</code></pre>


---

#### RESULTS

Output folder:

- [20190215_trinity_geoduck_gonad_01_RNAseq/](http://gannet.fish.washington.edu/Atumefaciens/20190215_trinity_geoduck_gonad_01_RNAseq/)

Trinity assembly:

- [20190215_trinity_geoduck_gonad_01_RNAseq/trinity_out_dir/Trinity.fasta](http://gannet.fish.washington.edu/Atumefaciens/20190215_trinity_geoduck_gonad_01_RNAseq/trinity_out_dir/Trinity.fasta)(FastA)

  - FastA index (```samtools faidx```):

    - [20190215_trinity_geoduck_gonad_01_RNAseq/trinity_out_dir/Trinity.fasta.fai](http://gannet.fish.washington.edu/Atumefaciens/20190215_trinity_geoduck_gonad_01_RNAseq/trinity_out_dir/Trinity.fasta.fai)

Assembly stats:

- [20190215_trinity_geoduck_gonad_01_RNAseq/assembly_stats.txt](http://gannet.fish.washington.edu/Atumefaciens/20190215_trinity_geoduck_gonad_01_RNAseq/assembly_stats.txt)

---

<pre><code>


################################
## Counts of transcripts, etc.
################################
Total trinity 'genes':	150013
Total trinity transcripts:	197407
Percent GC: 36.17

########################################
Stats based on ALL transcript contigs:
########################################

	Contig N10: 3251
	Contig N20: 2018
	Contig N30: 1342
	Contig N40: 904
	Contig N50: 638

	Median contig length: 315
	Average contig: 521.76
	Total assembled bases: 102998329


#####################################################
## Stats based on ONLY LONGEST ISOFORM per 'GENE':
#####################################################

	Contig N10: 2257
	Contig N20: 1328
	Contig N30: 873
	Contig N40: 626
	Contig N50: 474

	Median contig length: 289
	Average contig: 439.99
	Total assembled bases: 66003927
</code></pre>
