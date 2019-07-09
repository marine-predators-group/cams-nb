---
layout: post
title: Genome Annotation - Pgenerosa_v074 MAKER on Mox
date: '2019-07-01 10:29'
tags:
  - Panopea generosa
  - geoduck
  - MAKER
  - mox
  - annotation
  - genome
  - v074
categories:
  - Geoduck Genome Sequencing
---
[I previously created a subset of the Pgenerosa_v070 genome assembly](https://robertslab.github.io/sams-notebook/2019/06/25/Data-Wrangling-FastA-Subsetting-of-Pgenerosa_v070.fa-Using-samtools-faidx.html) that contains just the largest 18 scaffolds (these scaffolds were produced by Phase Genomics, utilizing some Hi-C sequencing). The new subsetted genome is labeled as [Pgenerosa_v074.fa](http://owl.fish.washington.edu/halfshell/genomic-databank/Pgenerosa_v074.fa) (914MB).

As part of that, [Steven wanted this version annotated using MAKER](https://github.com/RobertsLab/resources/issues/707).

Here are a list of the input files used for the various components of the MAKER annotation:


Transcriptome FastA files (links to notebook entries):
- [ctenidia](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Ctenidia-with-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [gonad](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Gonad-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [heart]()
- [EPI99 (larvae)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Larvae-Day5-EPI99-with-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [EPI115 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Super-Low-OA-EPI115-with-HiSeq-Data-on-Mox.html)
- [EPI116 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Super-Low-OA-EPI116-with-HiSeq-Data-on-Mox.html)
- [EPI123 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Ambient-OA-EPI123-with-HiSeq-Data-on-Mox.html)
- [EPI124 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Ambient-OA-EPI124-with-HiSeq-and-NovaSeq-Data-on-Mox.html)

### Path to Crassostrea gigas NCBI protein FastA
gigas_proteome=/gscratch/srlab/sam/data/C_gigas/gigas_ncbi_protein/GCA_000297895.1_oyster_v9_protein.faa

### Path to Crassostrea virginica NCBI protein FastA
virginica_proteome=/gscratch/srlab/sam/data/C_virginica/virginica_ncbi_protein/GCF_002022765.2_C_virginica-3.0_protein.faa

### Path to Panopea generosa TransDecoder protein FastAs
panopea_td_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/20180827_trinity_geoduck.fasta.transdecoder.pep
pgen_td_ctenidia_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/ctenidia/Trinity.fasta.transdecoder.pep
pgen_td_larvae_EPI99_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/larvae/EPI99/Trinity.fasta.transdecoder.pep
pgen_td_juv_EPI115_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/juvenile/EPI115/Trinity.fasta.transdecoder.pep
pgen_td_juv_EPI116_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/juvenile/EPI116/Trinity.fasta.transdecoder.pep
pgen_td_juv_EPI123_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/juvenile/EPI123/Trinity.fasta.transdecoder.pep
pgen_td_juv_EPI124_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/juvenile/EPI124/Trinity.fasta.transdecoder.pep
pgen_td_gonad_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/gonad/Trinity.fasta.transdecoder.pep
pgen_td_heart_proteome=/gscratch/srlab/sam/data/P_generosa/proteomes/heart/Trinity.fasta.transdecoder.pep


### Path to P.generosa-specific RepeatModeler library
repeat_library=/gscratch/srlab/sam/data/P_generosa/repeats/Pgenerosa_v074-families.fa

### Path to P.generosa-specific RepeatMasker GFF
rm_gff=/gscratch/srlab/sam/data/P_generosa/repeats/Pgenerosa_v074.fa.out.gff

### Path to SwissProt database for BLASTp
sp_db_blastp=/gscratch/srlab/blastdbs/UniProtKB_20190109/uniprot_sprot.fasta


---

#### RESULTS

Output folder:

- []()
